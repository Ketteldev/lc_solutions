defmodule Solution do
  @moduledoc """
  No gotchas today, just a clean solution that makes use of a MapSet. I was
  *almost* gotcha'd because the test cases provided did not include something
  like the following; "aAbBcCaA." This is only 3, because a should not be
  counted twice, and my original solution didn't account for this. But, I did
  catch it.
  """

  @spec number_of_special_chars(word :: String.t()) :: integer()
  def number_of_special_chars(word) do
    word
    |> String.to_charlist()
    |> Enum.reduce({0, MapSet.new()}, fn char, {count, seen} ->
      cond do
        MapSet.member?(seen, char) ->
          {count, seen}

        char in ?A..?Z and MapSet.member?(seen, char + 32) ->
          {count + 1, MapSet.put(seen, char)}

        char in ?A..?Z ->
          {count, MapSet.put(seen, char)}

        char in ?a..?z and MapSet.member?(seen, char - 32) ->
          {count + 1, MapSet.put(seen, char)}

        true ->
          {count, MapSet.put(seen, char)}
      end
    end)
    |> elem(0)
  end
end

Solution.number_of_special_chars("aAbBcC") |> IO.inspect(label: "Expecting 3, got")
Solution.number_of_special_chars("abc") |> IO.inspect(label: "Expecting 0, got")
Solution.number_of_special_chars("abBCab") |> IO.inspect(label: "Expecting 1, got")
Solution.number_of_special_chars("aAbBcCaA") |> IO.inspect(label: "Expecting 3, got")
