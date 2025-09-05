type ReadFn<T> = () => T;
type WriteFn<T> = (value: T) => void;
type CallbackFn = () => void;
type UpdateFn<T> = () => T;
type EqualFn<T> = (lhs: T, rhs: T) => boolean;
type UnsubscribeFn = () => void;
type InputPair<T> = [ReadFn<T>, WriteFn<T>];
type RefreshFn = () => boolean;
type InternalRefreshFn = () => void;
type Source<T> = {
  value: T | undefined;
  sinks: Set<Sink>;
};
type Sink = {
  sources: Set<Source<unknown>>;
  refresh: RefreshFn;
  isStale: boolean;
};
type Derived<T> = Source<T> & Sink;
const awaitRefresh: Set<RefreshFn> = new Set();
let refreshing: RefreshFn[] | undefined;
let activeSink: Sink | undefined;
function isSink(object: unknown): object is Sink {
  return typeof object === 'object' && (object as Sink).sources !== undefined;
}
const defaultEqual = <T>(lhs: T, rhs: T): boolean => lhs === rhs;
const neverEqual = <T>(_lhs: T, _rhs: T): boolean => false;
const refreshStub: RefreshFn = () => false;
function queueAsStale(sink: Sink): void {
  if (sink.isStale) return;
  sink.isStale = true;
  awaitRefresh.add(sink.refresh);
}
function markSubsStale(sinks: Set<Sink>): void {
  const subscriptions = Array.from(sinks);
  for (let i = 0; i < subscriptions.length; i += 1)
    queueAsStale(subscriptions[i]);
}
function isStale(sink: Source<unknown>): boolean {
  if (!isSink(sink)) return false;
  return sink.isStale;
}
const hasStaleSources: (s: Set<Source<unknown>>) => boolean = (sources) =>
  Array.from(sources).some(isStale);
function runRefresh(): void {
  if (refreshing) return;
  while (awaitRefresh.size > 0) {
    refreshing = Array.from(awaitRefresh);
    awaitRefresh.clear();
    for (let i = 0; i < refreshing.length; i += 1) {
      const refresh = refreshing[i];
      if (!refresh()) awaitRefresh.add(refresh);
    }
    refreshing = undefined;
  }
}
function subscribe(sink: Sink, source: Source<unknown>): void {
  source.sinks.add(sink);
  sink.sources.add(source);
}
function unsubscribe(sink: Sink): void {
  for (const source of sink.sources.values()) source.sinks.delete(sink);
  sink.sources.clear();
}
function makeReadFn<T>(source: Source<T>): ReadFn<T> {
  return (): T => {
    if (activeSink) subscribe(activeSink, source);
    return source.value!;
  };
}
function makeRefreshFn(sink: Sink, fn: InternalRefreshFn): RefreshFn {
  return (): boolean => {
    if (hasStaleSources(sink.sources)) return false;
    unsubscribe(sink);
    activeSink = sink;
    fn();
    activeSink = undefined;
    return true;
  };
}
function createInput<T>(value: T): InputPair<T> {
  const source: Source<T> = {
    value,
    sinks: new Set(),
  };
  const write: WriteFn<T> = (nextValue) => {
    source.value = nextValue;
    markSubsStale(source.sinks);
    runRefresh();
  };
  return [makeReadFn(source), write];
}
function createCallback(fn: CallbackFn): UnsubscribeFn {
  const sink: Sink = {
    sources: new Set(),
    refresh: refreshStub,
    isStale: false,
  };
  const refresh: InternalRefreshFn = () => {
    fn();
    sink.isStale = false;
  };
  sink.refresh = makeRefreshFn(sink, refresh);
  queueAsStale(sink);
  runRefresh();
  return unsubscribe.bind(null, sink);
}
function createComputed<T>(
  fn: UpdateFn<T>,
  _value?: T,
  equal?: boolean | EqualFn<T>
): ReadFn<T> {
  const equalFn =
    typeof equal === 'function'
      ? equal
      : equal === true
      ? defaultEqual
      : neverEqual;
  const derived: Derived<T> = {
    value: undefined,
    sinks: new Set(),
    sources: new Set(),
    refresh: refreshStub,
    isStale: false,
  };
  const refresh: InternalRefreshFn = () => {
    const nextValue = fn();
    derived.isStale = false;
    if (derived.value !== undefined && equalFn(derived.value, nextValue))
      return;
    derived.value = nextValue;
    markSubsStale(derived.sinks);
  };
  derived.refresh = makeRefreshFn(derived, refresh);
  queueAsStale(derived);
  runRefresh();
  return makeReadFn(derived);
}
export { createInput, createCallback, createComputed };