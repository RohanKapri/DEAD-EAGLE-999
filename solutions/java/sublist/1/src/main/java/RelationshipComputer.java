import java.util.*;
import java.util.stream.*;
class RelationshipComputer<T> {
    Relationship computeRelationship(List<T> firstList, List<T> secondList) {
        if (firstList.equals(secondList)) return Relationship.EQUAL;
        if (contains(firstList, secondList)) return Relationship.SUPERLIST;
        if (contains(secondList, firstList)) return Relationship.SUBLIST;
        return Relationship.UNEQUAL;
    }
    private boolean contains(List<T> firstList, List<T> secondList) {
        int size = secondList.size();
        return IntStream.range(0, firstList.size() - size + 1).anyMatch(i -> firstList.subList(i, i + size).equals(secondList));
    }
}
