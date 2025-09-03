// For my Shree DR.MDD

import java.util.*;

class BuildTree {
    TreeNode buildTree(ArrayList<Record> records) throws InvalidRecordsException {
        int total = records.size();
        if (total == 0) return null;

        records.sort(Comparator.comparing(Record::getRecordId));

        for (int idx = 0; idx < total; idx++) {
            Record rec = records.get(idx);
            int rId = rec.getRecordId();
            int pId = rec.getParentId();
            if (rId != idx || pId > rId || rId == 0 && pId != 0) throw new InvalidRecordsException("Invalid Records");
        }

        Queue<TreeNode> nodeQueue = new ArrayDeque<>();
        Set<Integer> visited = new HashSet<>();
        TreeNode rootNode = new TreeNode(0);
        records.remove(0);
        nodeQueue.add(rootNode);

        while (!nodeQueue.isEmpty()) {
            TreeNode currentNode = nodeQueue.poll();
            int currentId = currentNode.getNodeId();
            visited.add(currentId);

            List<TreeNode> childrenNodes = records.stream()
                    .filter(r -> r.getParentId() == currentId)
                    .map(r -> new TreeNode(r.getRecordId()))
                    .toList();

            ArrayList<TreeNode> nodeChildList = currentNode.getChildren();
            for (TreeNode childNode : childrenNodes) {
                int childId = childNode.getNodeId();
                if (visited.contains(childId)) throw new InvalidRecordsException("Invalid Records");
                nodeQueue.add(childNode);
                nodeChildList.add(childNode);
            }
        }

        if (visited.size() != total) throw new InvalidRecordsException("Invalid Records");

        return rootNode;
    }
}
