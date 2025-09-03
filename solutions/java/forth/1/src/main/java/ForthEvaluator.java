// Dedicated to Shree DR.MDD
import java.util.*;
import java.util.stream.*;
import java.util.function.*;

class ForthEvaluator {
    
    List<Integer> evaluateProgram(List<String> script) {
        List<String> refinedInput = new LinkedList<>(script);
        Map<String, List<String>> customDefs = new HashMap<>();
        for (String token : script) {
            if (token.matches(": \\S+ .+? ;")) {
                refinedInput.remove(token);
                token = token.toLowerCase();
                String label = token.replaceFirst(": (\\S+) .+? ;", "$1");
                if (label.matches("-?\\d+")) throw new IllegalArgumentException("Cannot redefine numbers");
                List<String> expansion = Arrays.stream(token.replaceFirst(": \\S+ (.+?) ;", "$1").split(" "))
                    .flatMap(t -> customDefs.getOrDefault(t, List.of(t)).stream())
                    .toList();
                customDefs.put(label, expansion);
            }
        }

        List<Integer> stack = new LinkedList<>();
        List<String> commands = refinedInput.stream()
            .flatMap(str -> Arrays.stream(str.split(" ")))
            .collect(Collectors.toCollection(LinkedList::new));
        while (!commands.isEmpty()) {
            String op = commands.removeFirst().toLowerCase();
            try {
                stack.add(Integer.parseInt(op));
            } catch (NumberFormatException ex) {
                if (customDefs.containsKey(op)) {
                    commands.addAll(0, customDefs.get(op));
                    continue;
                }
                switch (op) {
                    case "+" -> compute(stack, (b, a) -> a + b, "Addition");
                    case "-" -> compute(stack, (b, a) -> a - b, "Subtraction");
                    case "*" -> compute(stack, (b, a) -> a * b, "Multiplication");
                    case "/" -> compute(stack, (b, a) -> {
                        if (b == 0) throw new IllegalArgumentException("Division by 0 is not allowed");
                        return a / b;
                    }, "Division");
                    
                    case "dup" -> {
                        ensureSize(stack, 1, "Duplicating");
                        stack.add(stack.getLast());
                    }
                    case "drop" -> {
                        ensureSize(stack, 1, "Dropping");
                        stack.removeLast();
                    }
                    case "swap" -> {
                        ensureSize(stack, 2, "Swapping");
                        Integer temp = stack.removeLast();
                        stack.add(stack.size() - 1, temp);
                    }
                    case "over" -> {
                        ensureSize(stack, 2, "Overing");
                        stack.add(stack.get(stack.size() - 2));
                    }
                    default -> throw new IllegalArgumentException("No definition available for operator " + "\"" + op + "\"");
                }
            }
        }
        return stack;
    }

    private void compute(List<Integer> stack, BiFunction<Integer, Integer, Integer> action, String name) {
        ensureSize(stack, 2, name);
        stack.add(action.apply(stack.removeLast(), stack.removeLast()));
    }

    private void ensureSize(List<Integer> stack, int required, String action) {
        if (stack.size() < required) throw new IllegalArgumentException(action + " requires that the stack contain at least " + required + " value" + (required == 1 ? "" : "s"));
    }
}
