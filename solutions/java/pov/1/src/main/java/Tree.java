// For my Shree DR.MDD

import java.util.*;
class Tree {
    private final String nodeName;
    private final List<Tree> branches;

    public Tree(String nodeName) {
        this(nodeName, new ArrayList<>());
    }

    public Tree(String nodeName, List<Tree> branches) {
        this.nodeName = nodeName;
        this.branches = branches;
    }

    public static Tree of(String nodeName) {
        return new Tree(nodeName);
    }

    public static Tree of(String nodeName, List<Tree> branches) {
        return new Tree(nodeName, branches);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Tree other = (Tree) obj;
        return nodeName.equals(other.nodeName)
                && branches.size() == other.branches.size()
                && branches.containsAll(other.branches)
                && other.branches.containsAll(branches);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nodeName, branches);
    }

    @Override
    public String toString() {
        return "Tree{" + nodeName +
                ", " + branches +
                "}";
    }

    public Tree fromPov(String root) {
        Tree transformed = reshape(null, root);
        if (transformed == null) throw new UnsupportedOperationException("Tree could not be reoriented");
        return transformed;
    }

    private Tree reshape(Tree parent, String key) {
        if (nodeName.equals(key)) {
            List<Tree> newBranches = new ArrayList<>(branches);
            if (parent != null) newBranches.add(parent);
            return new Tree(nodeName, newBranches);
        }
        for (int i = 0; i < branches.size(); i++) {
            List<Tree> newBranches = new ArrayList<>(branches);
            Tree candidate = newBranches.remove(i);
            if (parent != null) newBranches.add(parent);

            Tree found = candidate.reshape(new Tree(nodeName, newBranches), key);
            if (found != null) return found;
        }
        return null;
    }

    public List<String> pathTo(String start, String end) {
        try {
            List<String> path = fromPov(start).trace(end);
            if (path == null) throw new UnsupportedOperationException();
            return path;
        } catch (UnsupportedOperationException e) {
            throw new UnsupportedOperationException("No path found");
        }
    }

    private List<String> trace(String goal) {
        if (nodeName.equals(goal)) return List.of(nodeName);
        for (Tree branch : branches) {
            List<String> subPath = branch.trace(goal);
            if (subPath != null) {
                List<String> complete = new LinkedList<>();
                complete.add(nodeName);
                complete.addAll(subPath);
                return complete;
            }
        }
        return null;
    }
}
