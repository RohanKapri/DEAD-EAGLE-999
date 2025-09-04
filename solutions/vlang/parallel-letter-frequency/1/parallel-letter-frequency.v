module main
import arrays
import encoding.utf8
fn calculate_frequencies(texts []string) map[rune]int {
    threads := texts.map(go frequencies(it))
    freqs := threads.wait()
    mut result := map[rune]int{}
    for freq in freqs {
        sum(mut result, freq)
    }
    return result
}
fn frequencies(text string) map[rune]int {
    return arrays.map_of_counts[rune](text.to_lower().runes().filter(utf8.is_letter(it)))
}
fn sum(mut m1 map[rune]int, m2 map[rune]int) {
    for k, v in m2 {
        m1[k] += v
    }
}