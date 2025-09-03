// For my Shree DR.MDD

public class Fighter {
    public Fighter() {        
    }

    boolean isVulnerable() {
        return false;
    }

    int getDamagePoints(Fighter opponent) {
        return 0;
    }
}

class Warrior extends Fighter {

    @Override
    boolean isVulnerable() {
        return false;
    }

    @Override
    public String toString() {
        return "Fighter is a Warrior";
    }

    @Override
    int getDamagePoints(Fighter opponent) {
        return opponent.isVulnerable() ? 10 : 6;
    }
}

class Wizard extends Fighter {
    private boolean spellPrepared = false;

    @Override
    boolean isVulnerable() {
        return !spellPrepared;
    }

    @Override
    int getDamagePoints(Fighter opponent) {
        return spellPrepared ? 12 : 3;
    }

    void prepareSpell() {
        this.spellPrepared = true;
    }

    @Override
    public String toString() {
        return "Fighter is a Wizard";
    }
}
