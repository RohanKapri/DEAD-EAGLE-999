// For my Shree DR.MDD

import java.util.*;
import java.util.function.*;

class ListOps {

    static <T> List<T> append(List<T> a, List<T> b) {
        List<T> merged = new LinkedList<>(a);
        for (T item : b) merged.add(item);
        return merged;
    }

    static <T> List<T> concat(List<List<T>> packs) {
        List<T> merged = new LinkedList<>();
        for (List<T> block : packs)
            for (T val : block) merged.add(val);
        return merged;
    }

    static <T> List<T> filter(List<T> base, Predicate<T> rule) {
        List<T> picked = new LinkedList<>();
        for (T element : base)
            if (rule.test(element)) picked.add(element);
        return picked;
    }

    static <T> int size(List<T> input) {
        int counter = 0;
        for (T ignored : input) counter++;
        return counter;
    }

    static <T, U> List<U> map(List<T> base, Function<T, U> transformer) {
        List<U> altered = new LinkedList<>();
        for (T val : base) altered.add(transformer.apply(val));
        return altered;
    }

    static <T> List<T> reverse(List<T> base) {
        List<T> flipped = new LinkedList<>();
        for (T val : base) flipped.addFirst(val);
        return flipped;
    }

    static <T, U> U foldLeft(List<T> base, U seed, BiFunction<U, T, U> op) {
        U accum = seed;
        for (T val : base) accum = op.apply(accum, val);
        return accum;
    }

    static <T, U> U foldRight(List<T> base, U seed, BiFunction<T, U, U> op) {
        U accum = seed;
        for (T val : reverse(base)) accum = op.apply(val, accum);
        return accum;
    }

    private ListOps() {
    }

}
