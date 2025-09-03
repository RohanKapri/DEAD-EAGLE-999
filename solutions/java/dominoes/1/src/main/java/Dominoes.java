import java.util.*;
class Dominoes {
    List<Domino> formChain(List<Domino> inputDominoes) throws ChainNotFoundException {
        if (inputDominoes.isEmpty()) return List.of();
        Deque<Domino> result = new ArrayDeque<>();
        if (inputDominoes.size() == 1) {
            Domino domino = inputDominoes.get(0);
            if (domino.getLeft() != domino.getRight()) throw new ChainNotFoundException("No domino chain found.");
        }
        if (!backtrack(inputDominoes, result, new HashSet<>())) throw new ChainNotFoundException("No domino chain found.");
        return List.copyOf(result);
    }
    private boolean backtrack(List<Domino> inputDominoes, Deque<Domino> result, Set<Integer> usedIndices) {
        if (result.size() == inputDominoes.size()) return result.getLast().getRight() == result.getFirst().getLeft();
        for (int i = 0; i < inputDominoes.size(); i++) {
            if (usedIndices.contains(i)) continue;
            for (int flip = 0; flip < 2; flip++) {
                Domino currentDomino = inputDominoes.get(i);
                if (flip == 1) currentDomino = new Domino(currentDomino.getRight(), currentDomino.getLeft());
                if (!result.isEmpty() && result.getLast().getRight() != currentDomino.getLeft()) continue;
                result.addLast(currentDomino);
                usedIndices.add(i);
                if (backtrack(inputDominoes, result, usedIndices)) return true;
                result.removeLast();
                usedIndices.remove(i);
            }
        }
        return false;
    }
}