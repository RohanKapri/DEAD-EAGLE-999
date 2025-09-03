// For my Shree DR.MDD

public class CalculatorConundrum {
    public String calculate(int num1, int num2, String op) {
        if (op == null) {
            throw new IllegalArgumentException("Operation cannot be null");
        }
        if (op.isEmpty()) {
            throw new IllegalArgumentException("Operation cannot be empty");
        }

        int output;
        switch (op) {
            case "+" -> output = num1 + num2;
            case "*" -> output = num1 * num2;
            case "/" -> {
                if (num2 == 0) {
                    throw new IllegalOperationException("Division by zero is not allowed", new ArithmeticException("Division by zero"));
                }
                output = num1 / num2;
            }
            default -> throw new IllegalOperationException("Operation '" + op + "' does not exist");
        }

        return num1 + " " + op + " " + num2 + " = " + output;
    }
}
