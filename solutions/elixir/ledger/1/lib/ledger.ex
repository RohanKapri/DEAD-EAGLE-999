defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @headers %{
    :en_US => "Date       | Description               | Change       \n",
    :nl_NL => "Datum      | Omschrijving              | Verandering  \n"
  }

  @currencies %{:eur => "€", :usd => "$"}
  @dec_sep %{:en_US => ".", :nl_NL => ","}
  @num_sep %{:en_US => ",", :nl_NL => "."}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    header = @headers[locale]

    case entries == [] do
      true ->
        header

      false ->
        entries = format_lines(entries, currency, locale)
        header <> entries <> "\n"
    end
  end

  defp format_lines(entries, currency, locale) do
    entries
    |> Enum.sort(&sorter/2)
    |> Enum.map(fn entry -> format_entry(currency, locale, entry) end)
    |> Enum.join("\n")
  end

  defp sorter(a, b) do
    cond do
      a.date.day < b.date.day -> true
      a.date.day > b.date.day -> false
      a.description < b.description -> true
      a.description > b.description -> false
      true -> a.amount_in_cents <= b.amount_in_cents
    end
  end

  defp format_entry(currency, locale, entry) do
    date = format_date(entry.date, locale)
    description = format_description(entry.description)
    amount = format_amount(entry.amount_in_cents, currency, locale)

    format_line(date, description, amount)
  end

  defp format_date(date, locale) do
    [year, month, day] = date |> Date.to_string() |> String.split("-")

    case locale == :en_US do
      true -> "#{month}/#{day}/#{year}"
      false -> "#{day}-#{month}-#{year}"
    end
  end

  defp format_description(description) do
    case String.length(description) > 26 do
      true -> " #{String.slice(description, 0, 22)}..."
      false -> " #{String.pad_trailing(description, 25, " ")}"
    end
  end

  defp format_amount(cents, currency, locale) do
    [whole, decimal] = whole_and_decimal(cents)
    whole = format_whole(whole, locale)
    number = format_number(whole, decimal, locale)
    currency = @currencies[currency]
    amount = get_amount(cents, currency, number, locale)
    String.pad_leading(amount, 14, " ")
  end

  defp whole_and_decimal(cents) do
    abs(cents / 100)
    |> :erlang.float_to_binary(decimals: 2)
    |> String.split(".")
  end

  defp format_whole(whole, locale) do
    whole
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> insert_separators(1, @num_sep[locale], [])
  end

  defp insert_separators([], _n, _sep, acc), do: acc

  defp insert_separators(list, 4, sep, acc) do
    insert_separators(list, 1, sep, [sep | acc])
  end

  defp insert_separators([h | t], n, sep, acc) do
    insert_separators(t, n + 1, sep, [h | acc])
  end

  defp format_number(whole, decimal, locale) do
    "#{whole}#{@dec_sep[locale]}#{decimal}"
  end

  defp get_amount(amount, currency, number, :en_US) when amount >= 0 do
    "#{currency}#{number} "
  end

  defp get_amount(amount, currency, number, :nl_NL) when amount >= 0 do
    "#{currency} #{number} "
  end

  defp get_amount(_amount, currency, number, :en_US) do
    " (#{currency}#{number})"
  end

  defp get_amount(_amount, currency, number, :nl_NL) do
    "#{currency} -#{number} "
  end

  defp format_line(date, description, amount) do
    "#{date} |#{description} |#{amount}"
  end
end