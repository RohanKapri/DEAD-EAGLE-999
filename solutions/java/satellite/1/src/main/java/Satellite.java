import java.util.*;
public class Satellite {
    public Tree treeFromTraversals(List<Character> preorderInput, List<Character> inorderInput) {
        if (preorderInput.size() != inorderInput.size()) throw new IllegalArgumentException("traversals must have the same length");
        if (new HashSet<>(preorderInput).size() < preorderInput.size()) throw new IllegalArgumentException("traversals must contain unique items");
        if (!preorderInput.stream().allMatch(inorderInput::contains)) throw new IllegalArgumentException("traversals must have the same elements");
        return new Tree(backtrack(preorderInput, inorderInput));
    }
    private Node backtrack(List<Character> preorderInput, List<Character> inorderInput) {
        if (preorderInput.isEmpty()) return null;
        
        char root = preorderInput.getFirst();
        int inorderIndex = inorderInput.indexOf(root);
        List<Character> inorderLeft = inorderInput.subList(0, inorderIndex),
            inorderRight = inorderInput.subList(inorderIndex + 1, inorderInput.size()),
            preorderLeft = preorderInput.stream().filter(inorderLeft::contains).toList(),
            preorderRight = preorderInput.stream().filter(inorderRight::contains).toList();
        return new Node(root, backtrack(preorderLeft, inorderLeft), backtrack(preorderRight, inorderRight));
    }
}
