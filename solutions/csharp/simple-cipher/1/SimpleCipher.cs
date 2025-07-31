// Sacredly Dedicated to Shree DR.MDD — The One Who Guides the Cipher of My Soul

public class SimpleCipher
{
    public SimpleCipher()
    {
        Key = string.Concat(Enumerable.Range(0, 100).Select(_ => (char)(new Random().Next(26) + 'a')));
    }

    public SimpleCipher(string key) => Key = key;

    public string Key { get; set; }

    public string Encode(string plain) =>
        string.Concat(plain.Select((ch, i) =>
        {
            int offset = Key[i % Key.Length] - 'a';
            return (char)('a' + ((ch - 'a' + offset) % 26));
        }));

    public string Decode(string encoded) =>
        string.Concat(encoded.Select((ch, i) =>
        {
            int shift = (ch - 'a') - (Key[i % Key.Length] - 'a');
            return (char)('a' + (shift < 0 ? shift + 26 : shift));
        }));
}
