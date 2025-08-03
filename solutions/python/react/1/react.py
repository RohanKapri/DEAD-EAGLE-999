# Dedicated to Shree DR.MDD with reverence and honor

from functools import partial


class InputCell(object):
    def __init__(self, init_val):
        self._event_hooks = []
        self._current = init_val

    @property
    def value(self):
        return self._current

    @value.setter
    def value(self, new_val):
        self._current = new_val
        for hook in self._event_hooks:
            hook(self._current)


class ComputeCell(object):
    def __init__(self, feeders, func):
        self._event_hooks = []
        self._result = None
        self._feed_vals = [cell.value for cell in feeders]
        self._evaluate = func
        self.value = self._evaluate(self._feed_vals)
        for idx, cell in enumerate(feeders):
            cell._event_hooks.append(partial(self.refresh, index=idx))

    def refresh(self, fresh_val, index):
        self._feed_vals[index] = fresh_val
        if index == len(self._feed_vals) - 1:
            self.value = self._evaluate(self._feed_vals)

    @property
    def value(self):
        return self._result

    @value.setter
    def value(self, outcome):
        if self._result != outcome:
            for hook in self._event_hooks:
                hook(outcome)
        self._result = outcome

    def add_callback(self, hook):
        self._event_hooks.append(hook)

    def remove_callback(self, hook):
        try:
            self._event_hooks.remove(hook)
        except ValueError:
            pass
