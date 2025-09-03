import java.util.List;
// import java.util.ArrayList;
import java.util.Random;
import java.util.Collections;
import java.util.stream.*;

class DnDCharacter {
    
    private final int strength = ability(rollDice());
    private final int dexterity = ability(rollDice());
    private final int constitution = ability(rollDice());
    private final int intelligence = ability(rollDice());
    private final int wisdom = ability(rollDice());
    private final int charisma = ability(rollDice());

   // public DnDCharacter() { // the void constructor is implicit
   // }

    int ability(List<Integer> scores) {
        // return scores.stream().sorted().skip(1).reduce(0, Integer::sum);
        /* int sum = 0;
        for (Integer x : scores) {
                sum += x;
        } */
        int sum = scores.stream()
                .mapToInt(Integer::intValue)
                .sum();

//        int sum = scores.stream().sum();  // Syntax error
        // return sum - scores.stream().min(Integer::compare).orElse(0); // 
        return sum - Collections.min(scores);
    }

    List<Integer> rollDice() {
        Random random = new Random();
        // List<Integer> listaResultadosDados = new ArrayList<>();
        List<Integer> resultsList = random.ints(4, 1, 7)
                                           .boxed()
                                           .collect(Collectors.toList());

/*        for (int i = 0; i<4; i++){
            listaResultadosDados.add(1 + random.nextInt(6));
        } */
        return resultsList;
    }

    int modifier(int input) {
        // return (int) Math.floor((input - 10) / 2.0);
        return Math.floorDiv(input - 10, 2);
    }

    int getStrength() {
        return this.strength;
    }

    int getDexterity() {
        return this.dexterity;
    }

    int getConstitution() {
        return this.constitution;
    }

    int getIntelligence() {
        return this.intelligence;
    }

    int getWisdom() {
        return this.wisdom;
    }

    int getCharisma() {
        return this.charisma;
    }

    int getHitpoints() {
        return 10 + this.modifier(this.constitution);
    }

}