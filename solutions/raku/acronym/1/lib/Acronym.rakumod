sub abbreviate ($phrase) is export {
    [~] $phrase.uc.split("- _".comb).map: *.comb.head
}