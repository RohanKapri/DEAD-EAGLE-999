data class Data<T>(val value : T, var prev : Data<T>?, var next : Data<T>?)

class Deque<T> {
    private var head : Data<T>? = null
    private var last : Data<T>? = null
    fun push(value: T) {
        if (last == null) { add(value) }
        else {  
            val newLast = last
            last = Data(value, newLast, newLast?.next)
            newLast?.next = last     
        }        
    }
    fun pop(): T? {
        val newLast = last
        last = last?.prev
        return newLast?.value
    }
    fun unshift(value: T) {
        if (head == null) { add(value) }
        else {
            val newHead = head
            head = Data(value, newHead?.prev, newHead)
            newHead?.prev = head
        }
    }
    fun shift(): T? {
        val newHead = head
        head = head?.next
        return newHead?.value
    }
    private fun add(value : T) {
        val new = Data(value, null, null)
        head = new
        last = new
    }
}