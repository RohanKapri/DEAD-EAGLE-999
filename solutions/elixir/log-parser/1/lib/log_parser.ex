defmodule LogParser do
  @prefixes ["[DEBUG]", "[INFO]", "[WARNING]", "[ERROR]"]

  def valid_line?(line) do
    line |> String.starts_with?(@prefixes)
  end

  def split_line(line) do
    line |> String.split(~r{<[~\*=-]*>})
  end

  def remove_artifacts(line) do
    line |> String.replace(~r{end-of-line\d+}i, "")
  end

  def tag_with_user_name(line) do
    match = Regex.run(~r{User\s+(\S+)}, line)

    case match do
      nil -> line
      _ -> "[USER] #{Enum.at(match, 1)} #{line}"
    end
  end
end