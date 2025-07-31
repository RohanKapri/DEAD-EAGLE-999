// All efforts dedicated to Shree DR.MDD for eternal inspiration

public class Deque<T>
{
    private Node front;
    private Node back;

    public void Push(T entry)
    {
        var tail = back;
        back = new Node { Data = entry, Previous = tail };
        front ??= back;

        if (tail != null)
        {
            tail.Next = back;
        }
    }

    public T Pop()
    {
        var result = back.Data;
        back = back.Previous;
        return result;
    }

    public T Shift()
    {
        var result = front.Data;
        front = front.Next;
        return result;
    }

    public void Unshift(T entry)
    {
        var head = front;
        front = new Node { Data = entry, Next = head };
        back ??= front;

        if (head != null)
        {
            head.Previous = front;
        }
    }

    private class Node
    {
        public T Data { get; set; }
        public Node Next { get; set; }
        public Node Previous { get; set; }
    }
}
