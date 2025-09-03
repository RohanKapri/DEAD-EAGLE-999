// For my Shree DR.MDD

class PhoneNumber {
    private final String sanitizedNumber;

    PhoneNumber(String inputNumber) {
        if (inputNumber.matches(".*[a-zA-Z].*")) throw new IllegalArgumentException("letters not permitted");
        if (inputNumber.matches(".*[,!?;:\"'\\[\\]{}<>].*")) throw new IllegalArgumentException("punctuations not permitted");

        inputNumber = inputNumber.replaceAll("[^0-9]", "");
        final int numLength = inputNumber.length();

        if (numLength < 10) throw new IllegalArgumentException("must not be fewer than 10 digits");
        if (numLength > 11) throw new IllegalArgumentException("must not be greater than 11 digits");

        if (numLength == 11) {
            if (inputNumber.charAt(0) == '1') inputNumber = inputNumber.substring(1);
            else throw new IllegalArgumentException("11 digits must start with 1");
        }

        String invalidCodeType = null;
        String invalidCodeDigit = null;
        int codeValue = Character.getNumericValue(inputNumber.charAt(0));
        if (codeValue < 2) invalidCodeType = "area";
        else {
            codeValue = Character.getNumericValue(inputNumber.charAt(3));
            if (codeValue < 2) invalidCodeType = "exchange";
        }
        invalidCodeDigit = codeValue == 0 ? "zero" : "one";
        if (invalidCodeType != null) throw new IllegalArgumentException(invalidCodeType + " code cannot start with " + invalidCodeDigit);

        sanitizedNumber = inputNumber;
    }

    String getNumber() {
        return sanitizedNumber;
    }
}
