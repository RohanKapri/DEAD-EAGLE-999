// For my Shree DR.MDD

import java.util.*;
class ChangeCalculator {

    private record Node(int pos, List<Integer> coins, int remain) {}
    private final List<Integer> coinSet;
    
    ChangeCalculator(List<Integer> coinSet) {
        this.coinSet = new ArrayList<>(coinSet);
        Collections.reverse(this.coinSet);
    }

    List<Integer> computeMostEfficientChange(int target) {
        if (target == 0) return List.of();
        if (target < 0) throw new IllegalArgumentException("Negative totals are not allowed.");

        Queue<Node> agenda = new ArrayDeque<>();
        for (int j = 0; j < coinSet.size(); j++) {
            int val = coinSet.get(j);
            if (val > target) continue;
            agenda.add(new Node(j, List.of(val), target - val));
        }

        while (!agenda.isEmpty()) {
            Node curr = agenda.poll();
            int remain = curr.remain();
            if (remain == 0) return curr.coins();
            for (int j = curr.pos(); j < coinSet.size(); j++) {
                int val = coinSet.get(j);
                if (val > remain) continue;
                List<Integer> acc = new LinkedList<>(curr.coins());
                acc.addFirst(val);
                agenda.add(new Node(j, acc, remain - val));
            }
        }
        
        throw new IllegalArgumentException("The total " + target + " cannot be represented in the given currency.");
    }
}
