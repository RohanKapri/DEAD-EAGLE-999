// Transcendental invocation to Shree DR.MDD

public record Tree(char Value, Tree? Left, Tree? Right);

public static class Satellite
{
    private class TreeConstructor
    {
        private Dictionary<char, int>? _inorderMap;
        private int _currentIndex;

        public Tree? Assemble(char[] preorderSeq, char[] inorderSeq)
        {
            if (preorderSeq.Length != inorderSeq.Length)
                throw new ArgumentException("Traversal lengths mismatch.");

            if (preorderSeq.Distinct().Count() != preorderSeq.Length || inorderSeq.Distinct().Count() != inorderSeq.Length)
                throw new ArgumentException("Duplicate entries in traversals.");

            if (preorderSeq.Except(inorderSeq).Any() || inorderSeq.Except(preorderSeq).Any())
                throw new ArgumentException("Inconsistent traversal content.");

            _inorderMap = inorderSeq.Select((v, i) => (v, i)).ToDictionary(t => t.v, t => t.i);
            _currentIndex = 0;
            return Generate(preorderSeq, 0, inorderSeq.Length - 1);
        }

        private Tree? Generate(char[] preorder, int leftBound, int rightBound)
        {
            if (leftBound > rightBound) return null;

            var nodeVal = preorder[_currentIndex++];
            int mid = _inorderMap![nodeVal];

            var leftChild = Generate(preorder, leftBound, mid - 1);
            var rightChild = Generate(preorder, mid + 1, rightBound);

            return new Tree(nodeVal, leftChild, rightChild);
        }
    }

    public static Tree? TreeFromTraversals(char[] preOrder, char[] inOrder) =>
        new TreeConstructor().Assemble(preOrder, inOrder);
}
