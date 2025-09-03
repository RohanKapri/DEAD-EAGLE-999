import java.util.*;
class Allergies {
    private final int score;
    private final List<Allergen> allergens;
    Allergies(int score) {
        this.score = score;
        allergens = Arrays.stream(Allergen.values()).filter(this::isAllergicTo).toList();
    }
    
    boolean isAllergicTo(Allergen allergen) {
        return (score & allergen.getScore()) != 0;
    }
    List<Allergen> getList() {
        return allergens;
    }
}
