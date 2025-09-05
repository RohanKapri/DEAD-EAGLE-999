class Reactor<T>() {
    interface Subscription {
        fun cancel()
    }

    abstract class Cell<T> {
        abstract var value: T
        private val subscriptions: MutableList<(T) -> Unit> = ArrayList()
        private var lastCallbackValue: T? = null

        protected fun triggerCallbacks() {
            val newCallbackValue = this.value
            if (newCallbackValue != lastCallbackValue) {
                subscriptions.forEach { it(this.value) }
                lastCallbackValue = newCallbackValue
            }
        }

        fun addCallback(compute: (T) -> Unit) : Subscription {
            subscriptions.add(compute)
            return object : Subscription {
                override fun cancel() {
                    subscriptions.remove(compute)
                }
            }
        }
    }

    inner class InputCell<T>(initialValue: T) : Cell<T>() {
        private var innerValue: T = initialValue
        override var value: T
            get() { return innerValue }
            set(value) {
                if (innerValue != value) {
                    innerValue = value
                    this.triggerCallbacks()
                }
            }
    }

    inner class ComputeCell<T>(vararg private val inputCells: Reactor.Cell<T>, private val compute: (List<T>) -> T) : Cell<T>() {
        override var value: T
            get() { return computeValue() }
            set(value) {}

        init {
            inputCells.forEach { inputCell ->
                inputCell.addCallback {
                    this.triggerCallbacks()
                }
            }
            this.triggerCallbacks()
        }

        private fun computeValue() : T {
            return compute(this.inputCells.map { it.value }.toList())
        }
    }
}