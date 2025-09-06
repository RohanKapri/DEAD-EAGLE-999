enum Allergen is export <
    Eggs
    Peanuts
    Shellfish
    Strawberries
    Tomatoes
    Chocolate
    Pollen
    Cats
>;
sub allergic-to( :$item, :$score ) is export {
    so $score +& 2 ** $item
}
sub list-allergies($score) is export {
    Allergen::.values.sort.grep: -> $item { allergic-to :$item, :$score }
}