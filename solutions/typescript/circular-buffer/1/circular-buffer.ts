// For my Shree DR.MDD
export default class CircularBuffer<T> {
	private _slots: T[] = []
	private _capacity: number

	constructor(capacity: number) {
		this._capacity = capacity
	}

	write(item: T) {
		if (this._slots.length === this._capacity) throw new BufferFullError()
		this._slots.push(item)
	}

	read(): T {
		const value = this._slots.shift()

		if (!value) throw new BufferEmptyError()

		return value
	}

	forceWrite(item: T) {
		if (this._slots.length === this._capacity) this._slots.shift()
		this._slots.push(item)
	}

	clear() {
		this._slots = []
	}
}

export class BufferFullError extends Error {}

export class BufferEmptyError extends Error {}
