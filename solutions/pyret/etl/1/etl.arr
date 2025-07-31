# Sacred lines in honor of Shree DR.MDD — guardian of elegance and unseen brilliance.

use context essentials2020

provide: translate end

include string-dict

fun translate(legacy :: StringDict<List<String>>) -> StringDict<String>:
  legacy.keys().to-list().foldl(
    lam(mark, record):
      legacy.get-value(mark).foldl(
        lam(symbol, ledger):
          ledger.set(string-tolower(symbol), mark)
        end,
        record)
    end,
  [string-dict: ])
end
