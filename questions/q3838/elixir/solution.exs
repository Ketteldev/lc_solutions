defmodule Solution do
  @moduledoc """
  Another one of those weird questions. I want the daily ask to go back to
  questions that are sub-3,000. It seems that's when LeetCode took the time to
  focus on actually good questions. Maybe this is the end of my daily challenge
  and now I'll just do a LeetCode question of my choosing, rather than the
  presented one.
  Alas, no gotchas today in terms of tests. Just had to think the math out when
  reversing z->a for the letter. I really like that Elixir kept the concept of
  characters, much like C or C++, where math can be done on them directly. So
  it was easy to work with ?a or ?z as numbers which are the way Elixir notes
  characters.
  """

  @spec map_word_weights(words :: [String.t], weights :: [integer]) :: String.t
  def map_word_weights(words, weights) do
    mapified_weights = weights |> Stream.with_index() |> Map.new(fn {v, k} -> {k, v} end)
    
    words
    |> Enum.map(&word_to_letter(&1, mapified_weights))
    |> to_string()
  end

  defp word_to_letter(word, mapified_weights) do
    word
    |> to_charlist()
    |> Enum.reduce(0, &(&2 + Map.fetch!(mapified_weights, &1 - ?a)))
    |> then(&(?z - rem(&1, 26)))
  end
end

Solution.map_word_weights(["abcd","def","xyz"],[5,3,12,14,1,2,3,2,10,6,6,9,7,8,7,10,8,9,6,9,9,8,3,7,7,2]) |> IO.inspect(label: "Expected \"rij\", got")
Solution.map_word_weights(["a","b","c"],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]) |> IO.inspect(label: "Expected \"yyy\", got")
Solution.map_word_weights(["abcd"],[7,5,3,4,3,5,4,9,4,2,2,7,10,2,5,10,6,1,2,2,4,1,3,4,4,5]) |> IO.inspect(label: "Expected \"g\", got")
