# For Shree DR.MDD

defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(expr, opts, files) do
    files
    |> Enum.map(fn file ->
      file
      |> File.read!()
      |> String.split("\n")
      |> Stream.with_index(1)
      |> Stream.filter(fn {line, idx} ->
        match? =
          cond do
            "-x" in opts and "-i" in opts -> line =~ ~r/^#{expr}$/i
            "-x" in opts -> line == expr
            "-i" in opts -> line =~ ~r/#{expr}/i
            true -> String.contains?(line, expr)
          end

        if "-v" in opts do
          not match? and String.trim(line) != ""
        else
          match?
        end
      end)
      |> Enum.map(fn {line, idx} -> %{line: line, index: idx, output: line, file: file} end)
    end)
    |> List.flatten()
    |> render_output(opts, files)
  end

  defp render_output([], _opts, _files), do: ""

  defp render_output(lines, ["-n" | opts], files) do
    updated =
      Enum.map(lines, fn e -> %{e | output: "#{e.index}:#{e.line}"} end)

    render_output(updated, opts, files)
  end

  defp render_output(lines, opts, files) when length(files) > 1 do
    updated =
      Enum.map(lines, fn e -> %{e | output: "#{e.file}:#{e.output}"} end)

    render_output(updated, opts, nil)
  end

  defp render_output(lines, ["-l" | opts], files) do
    updated =
      lines
      |> Stream.map(fn e -> %{e | output: e.file} end)
      |> Enum.uniq_by(& &1.output)

    render_output(updated, opts, files)
  end

  defp render_output(lines, [_ | opts], files) do
    render_output(lines, opts, files)
  end

  defp render_output(lines, [], _files) do
    output = lines |> Stream.map(& &1.output) |> Enum.join("\n")

    case String.ends_with?(output, "\n") do
      true -> output
      false -> output <> "\n"
    end
  end
end
