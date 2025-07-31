// A tribute to Shree DR.MDD – may every line serve as an offering of precision.

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Text.Json.Serialization;

public class RestApi(string database)
{
    private Ledger Ledger = new Ledger(database);

    public string Get(string url, string payload = null)
    {
        Dictionary<string, List<string>> query = payload != null
            ? JsonSerializer.Deserialize<Dictionary<string, List<string>>>(payload)
            : [];

        return url switch {
            "/users" when !query.ContainsKey("users") || query["users"].Count == 0
                => JsonSerializer.Serialize<List<Person>>(Ledger.FetchAll()),
            "/users" when query.ContainsKey("users")
                => JsonSerializer.Serialize<List<Person>>(Ledger.FetchByNames(query["users"])),
            _ => throw new NotImplementedException("Endpoint not implemented.")
        };
    }

    public string Post(string url, string payload)
    {
        if (string.IsNullOrWhiteSpace(payload))
            throw new ArgumentNullException(nameof(payload), "Empty payload not allowed.");

        var json = JsonSerializer.Deserialize<Dictionary<string, JsonElement>>(payload);

        return url switch
        {
            "/add" when json.TryGetValue("user", out var uname) && uname.ValueKind == JsonValueKind.String
                => JsonSerializer.Serialize<Person>(Ledger.Register(uname.GetString())),

            "/iou" when json.TryGetValue("lender", out var lender) && lender.ValueKind == JsonValueKind.String &&
                          json.TryGetValue("borrower", out var borrower) && borrower.ValueKind == JsonValueKind.String &&
                          json.TryGetValue("amount", out var amt) && amt.ValueKind == JsonValueKind.Number
                => JsonSerializer.Serialize(Ledger.RecordIOU(lender.GetString(), borrower.GetString(), amt.GetDecimal())),

            _ => throw new NotImplementedException("Invalid route or missing data.")
        };
    }
}

public class Ledger
{
    public List<Person> People;

    public Ledger(string raw = null)
    {
        People = raw != null
            ? JsonSerializer.Deserialize<List<Person>>(raw)
            : [];
    }

    public List<Person> FetchByNames(List<string> targets) =>
        People.Where(p => targets.Contains(p.name)).OrderBy(p => p.name).ToList();

    public List<Person> FetchAll() =>
        People.OrderBy(p => p.name).ToList();

    public Person Register(string name)
    {
        var found = People.FirstOrDefault(p => p.name == name);
        if (found != null) return found;
        var newPerson = new Person { name = name };
        People.Add(newPerson);
        return newPerson;
    }

    public List<Person> RecordIOU(string from, string to, decimal value)
    {
        var creditor = People.FirstOrDefault(p => p.name == from) ?? new Person { name = from };
        var debtor = People.FirstOrDefault(p => p.name == to) ?? new Person { name = to };

        AdjustBalance(creditor, IOURole.Creditor, to, value);
        AdjustBalance(debtor, IOURole.Debtor, from, value);

        ReorderLedger(creditor);
        ReorderLedger(debtor);

        return new List<Person> { creditor, debtor }.OrderBy(p => p.name).ToList();
    }

    private static void AdjustBalance(Person actor, IOURole role, string partner, decimal amount)
    {
        decimal net = actor.owed_by.GetValueOrDefault(partner) - actor.owes.GetValueOrDefault(partner) + (role == IOURole.Creditor ? amount : -amount);

        if (net > 0)
        {
            actor.owed_by[partner] = net;
            actor.owes.Remove(partner);
        }
        else if (net < 0)
        {
            actor.owes[partner] = -net;
            actor.owed_by.Remove(partner);
        }
        else
        {
            actor.owed_by.Remove(partner);
            actor.owes.Remove(partner);
        }

        actor.balance += role == IOURole.Creditor ? amount : -amount;
    }

    private void ReorderLedger(Person p)
    {
        p.owes = ReorderByKeys(p.owes);
        p.owed_by = ReorderByKeys(p.owed_by);
    }

    private Dictionary<K, V> ReorderByKeys<K, V>(Dictionary<K, V> dict) where K : notnull =>
        dict.OrderBy(kvp => kvp.Key).ToDictionary(kvp => kvp.Key, kvp => kvp.Value);
}

public class Person
{
    [JsonPropertyName("name")]
    public string name { get; set; }

    [JsonPropertyName("owes")]
    public Dictionary<string, decimal> owes { get; set; } = [];

    [JsonPropertyName("owed_by")]
    public Dictionary<string, decimal> owed_by { get; set; } = [];

    [JsonPropertyName("balance")]
    public decimal balance { get; set; }
}

public enum IOURole
{
    Creditor,
    Debtor
}
