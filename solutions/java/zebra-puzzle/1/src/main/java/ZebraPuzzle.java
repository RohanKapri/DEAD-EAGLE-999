// For my Shree DR.MDD

import java.util.*;
import java.util.function.*;

class ZebraPuzzle {

    private final int TOTAL_HOUSES = 5;

    private final Map<String, Set<String>> ATTRIBUTES = Map.of(
        "house", Set.of("red", "green", "ivory", "yellow", "blue"),
        "nation", Set.of("Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"),
        "animal", Set.of("zebra", "dog", "snail", "fox", "horse"),
        "drink", Set.of("water", "coffee", "tea", "milk", "orange juice"),
        "pastime", Set.of("dancing", "painting", "reading", "football", "chess")
    );

    private final String[] ORDER_KEYS = {"house", "nation", "pastime", "animal", "drink"};

    private final Set<Supplier<Boolean>> CONSTRAINTS = Set.of(
        () -> samePlace("nation", "Englishman", "house", "red"),
        () -> samePlace("nation", "Spaniard", "animal", "dog"),
        () -> samePlace("house", "green", "drink", "coffee"),
        () -> samePlace("nation", "Ukrainian", "drink", "tea"),
        () -> checkDistance("house", "green", "house", "ivory", 1),
        () -> samePlace("animal", "snail", "pastime", "dancing"),
        () -> samePlace("house", "yellow", "pastime", "painting"),
        () -> atPosition(2, "drink", "milk"),
        () -> atPosition(0, "nation", "Norwegian"),
        () -> neighbors("pastime", "reading", "animal", "fox"),
        () -> neighbors("pastime", "painting", "animal", "horse"),
        () -> samePlace("pastime", "football", "drink", "orange juice"),
        () -> samePlace("nation", "Japanese", "pastime", "chess"),
        () -> neighbors("nation", "Norwegian", "house", "blue")
    );

    private boolean samePlace(String k1, String v1, String k2, String v2) {
        return checkDistance(k1, v1, k2, v2, 0);
    }

    private boolean neighbors(String k1, String v1, String k2, String v2) {
        return checkDistance(k1, v1, k2, v2, 1) || checkDistance(k1, v1, k2, v2, -1);
    }

    private boolean atPosition(int idx, String key, String val) {
        Map<String, String> house = locate(key, val);
        if (house == null) return true;
        return idx == arrangement.indexOf(house);
    }

    private boolean checkDistance(String k1, String v1, String k2, String v2, int gap) {
        Map<String, String> h1 = locate(k1, v1), h2 = locate(k2, v2);
        if (h1 == null || h2 == null) return true;
        return arrangement.indexOf(h1) - arrangement.indexOf(h2) == gap;
    }

    private final List<Map<String, String>> arrangement = new ArrayList<>(TOTAL_HOUSES);
    private final Map<String, Set<List<String>>> memo = new HashMap<>();

    public ZebraPuzzle() {
        for (int i = 0; i < TOTAL_HOUSES; i++) {
            arrangement.add(new HashMap<>());
        }
        solve(0);
    }

    private boolean solve(int step) {
        if (step > 0 && !validSoFar()) return false;
        if (step == TOTAL_HOUSES) return true;

        String prop = ORDER_KEYS[step];
        for (List<String> perm : generate(prop)) {
            for (int i = 0; i < TOTAL_HOUSES; i++) {
                arrangement.get(i).put(prop, perm.get(i));
            }
            if (solve(step + 1)) return true;
            for (Map<String, String> h : arrangement) {
                h.remove(prop);
            }
        }
        return false;
    }

    private Set<List<String>> generate(String prop) {
        return memo.computeIfAbsent(prop, k -> {
            Set<List<String>> out = new HashSet<>();
            Set<String> values = ATTRIBUTES.get(prop);
            buildPermutations(out, new ArrayList<>(values), values.size(), 0);
            return out;
        });
    }

    private void buildPermutations(Set<List<String>> res, List<String> vals, int size, int start) {
        if (start == size) {
            res.add(new ArrayList<>(vals));
            return;
        }
        for (int i = start; i < size; i++) {
            Collections.swap(vals, start, i);
            buildPermutations(res, vals, size, start + 1);
            Collections.swap(vals, start, i);
        }
    }

    private boolean validSoFar() {
        for (Supplier<Boolean> c : CONSTRAINTS) {
            if (!c.get()) return false;
        }
        return true;
    }

    private Map<String, String> locate(String key, String val) {
        return arrangement.stream()
            .filter(map -> val.equals(map.get(key)))
            .findFirst()
            .orElse(null);
    }

    String getWaterDrinker() {
        return locate("drink", "water").get("nation");
    }

    String getZebraOwner() {
        return locate("animal", "zebra").get("nation");
    }
}
