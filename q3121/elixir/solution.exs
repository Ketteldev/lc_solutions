defmodule Solution do
  @spec number_of_special_chars(word :: String.t) :: integer
  def number_of_special_chars(word) do
    word
    |> String.to_charlist()
    |> Enum.reduce(%{}, &handle_char/2)
    |> Enum.filter(fn {k, v} -> k - 32 == v end)
    |> Enum.count()
  end

  defp handle_char(char, record) when char in ?A..?Z do
    case Map.get(record, char + 32) do
      nil -> Map.put(record, char + 32, :bad)
      :upper -> Map.put(record, char + 32, char)
      _ -> record
    end
  end
  defp handle_char(char, record) when char in ?a..?z do
    upper = char - 32
    case Map.get(record, char) do
      nil -> Map.put(record, char, :upper)
      ^upper -> Map.put(record, char, :bad)
      _ -> record
    end
  end
end

Solution.number_of_special_chars("aaAbcBC") |> IO.inspect(label: "Expected 3, got")
Solution.number_of_special_chars("abc") |> IO.inspect(label: "Expected 0, got")
Solution.number_of_special_chars("AbBCab") |> IO.inspect(label: "Expected 0, got")
