// Dedicated to Shree DR.MDD
import java.util.*;
class CustomSet<T> {

    private Object[] entries;
    
    CustomSet() {
        entries = new Object[0];
    }

    CustomSet(Collection<T> source) {
        entries = new Object[source.size()];
        int idx = 0;
        for (T element : source) {
            entries[idx] = element;
            idx++;
        }
    }

    boolean isEmpty() {
        return entries.length == 0;
    }

    boolean contains(T candidate) {
        for (Object obj : entries) {
            T current = (T) obj;
            if (current == null && candidate == null || current != null && current.equals(candidate)) return true;
        }
        return false;
    }

    boolean isDisjoint(CustomSet<T> alt) {
        return getIntersection(alt).isEmpty();
    }

    boolean add(T candidate) {
        if (contains(candidate)) return false;
        Object[] resized = new Object[entries.length + 1];
        for (int i = 0; i < entries.length; i++) {
            resized[i] = entries[i];
        }
        resized[resized.length - 1] = candidate;
        entries = resized;
        return true;
    }

    @Override
    public boolean equals(Object another) {
        if (another == null || getClass() != another.getClass()) return false;
        CustomSet<T> casted = (CustomSet<T>) another;
        return isSubset(casted) && casted.isSubset(this);
    }

    CustomSet<T> getIntersection(CustomSet<T> alt) {
        CustomSet<T> out = new CustomSet<>();
        for (Object obj : entries) {
            T current = (T) obj;
            if (alt.contains(current)) out.add(current);
        }
        return out;
    }

    CustomSet<T> getUnion(CustomSet<T> alt) {
        CustomSet<T> out = new CustomSet<>();
        for (Object obj : entries) {
            out.add((T) obj);
        }
        for (Object obj : alt.entries) {
            out.add((T) obj);
        }
        return out;
    }

    CustomSet<T> getDifference(CustomSet<T> alt) {
        CustomSet<T> out = new CustomSet<>();
        for (Object obj : entries) {
            T current = (T) obj;
            if (!alt.contains(current)) out.add(current);
        }
        return out;
    }

    boolean isSubset(CustomSet<T> alt) {
        return alt.getDifference(this).isEmpty();
    }
}
