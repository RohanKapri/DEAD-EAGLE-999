class Acronym {
    String acronym;
    Acronym(String phrase) {
        acronym = phrase.replaceAll("_*(\\w)[\\w']*", "$1").replaceAll("\\W", "").toUpperCase();
    }

    String get() {
        return acronym;
    }

}