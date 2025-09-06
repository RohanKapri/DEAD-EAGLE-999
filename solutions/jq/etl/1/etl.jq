.legacy
| to_entries
| map({key: (.value[] | ascii_downcase), value: (.key | tonumber)})
| sort_by(.key)     # plain `sort` works too
| from_entries