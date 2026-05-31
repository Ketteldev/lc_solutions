defmodule Solution do
  @moduledoc """
  No gotchas again today. The approach is to make use of a map, using the
  lowercase letter as the key. The values at the key are one of 3; `:upper` for
  setting the expectation that it is waiting for the uppercase character to be
  seen, `[UPPER]` when the uppercase character has been found, and `:bad` for
  when either the uppercase has been seen first, or a lowercase has been seen
  after the uppercase appearance.

  Counting up to 26 possible key-value pairs results in O(26) worst case, ergo
  the count is just O(1). So the total here would be O(n) for the string that is
  passed in.
  """

  @spec number_of_special_chars(word :: String.t) :: integer
  def number_of_special_chars(word) do
    word
    |> String.to_charlist()
    |> Enum.reduce(%{}, &handle_char/2)
    |> Enum.count(fn {k, v} -> k - 32 == v end)
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
