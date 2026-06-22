defmodule Solution do
  @moduledoc """
  Nifty little problem. I debated a few solutions, before ultimately settling on
  this one. Just count the needed characters, and the minimum number is the
  maximum number of times we can spell out the word. Of course, that is why one
  must divide by 2 both L and O before checking the minimums.
  """

  @start %{?b => 0, ?a => 0, ?l => 0, ?o => 0, ?n => 0}

  @balloon [?b, ?a, ?l, ?o, ?n]

  @spec max_number_of_balloons(text :: String.t) :: integer
  def max_number_of_balloons(text) do
    text
    |> to_charlist()
    |> Enum.reduce(@start, fn
      char, counts when char in @balloon ->
        Map.update(counts, char, 1, &(&1 + 1))

      _char, counts ->
        counts
    end)
    |> Map.update!(?l, &div(&1, 2))
    |> Map.update!(?o, &div(&1, 2))
    |> Map.values()
    |> Enum.min()
  end
end
