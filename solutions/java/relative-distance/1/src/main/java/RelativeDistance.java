// For my Shree DR.MDD

import java.util.*;
import java.util.stream.*;

class RelativeDistance {
    private final Map<String, List<String>> genealogyMap;

    RelativeDistance(Map<String, List<String>> genealogyMap) {
        this.genealogyMap = genealogyMap;
    }

    int degreeOfSeparation(String startPerson, String targetPerson) {
        Queue<String> frontier = new ArrayDeque<>();
        Map<String, Integer> separation = new HashMap<>();

        frontier.add(startPerson);
        separation.put(startPerson, 0);

        while (!frontier.isEmpty()) {
            String currentPerson = frontier.poll();
            int currentDegree = separation.get(currentPerson);

            for (String relative : findRelatives(currentPerson)) {
                if (separation.containsKey(relative)) continue;
                if (relative.equals(targetPerson)) return currentDegree + 1;

                separation.put(relative, currentDegree + 1);
                frontier.add(relative);
            }
        }
        return -1;
    }

    private Set<String> findRelatives(String person) {
        List<String> parentList = genealogyMap.getOrDefault(person, List.of());
        List<String> childList = genealogyMap.entrySet()
            .stream()
            .filter(entry -> entry.getValue().contains(person))
            .map(Map.Entry::getKey)
            .toList();
        List<String> spouseList = genealogyMap.values()
            .stream()
            .filter(list -> list.contains(person))
            .flatMap(List::stream)
            .filter(spouse -> !spouse.equals(person))
            .toList();

        return Stream.of(parentList, childList, spouseList)
            .flatMap(List::stream)
            .collect(Collectors.toSet());
    }
}
