defmodule Inflex.Camelize do
  @moduledoc false

  def camelize(word, option \\ :upper) do
    case Regex.split(camelize_regex(), to_string(word)) do
      words ->
        words
        |> Enum.filter(&(&1 != ""))
        |> camelize_list(option)
        |> Enum.join()
    end
  end

  defp camelize_list([], _), do: []

  defp camelize_list([h | tail], :lower) do
    [lowercase(h)] ++ camelize_list(tail, :upper)
  end

  defp camelize_list([h | tail], :upper) do
    [capitalize(h)] ++ camelize_list(tail, :upper)
  end

  def capitalize(word), do: String.capitalize(word)
  def lowercase(word), do: String.downcase(word)

  defp camelize_regex, do: ~r/(?:^|[-_])|(?=[A-Z][a-z])/
end
