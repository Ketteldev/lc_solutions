defmodule Solution do
  @moduledoc """
  I wasn't really sure if the greedy sort was the way to solve this the most
  efficiently. I was thinking that there might be some tricky math solution
  that would get it in `O(n)`. However, after submitting my solution, and then
  looking at the other solutions in other languages (C++), it looks like the
  greedy sort and skipping every third candy was the optimal solution. That
  said, no 'gotchas' today.
  """

  @spec minimum_cost(cost :: [integer]) :: integer
  def minimum_cost(cost) do
    cost
    |> Enum.sort(:desc)
    |> Stream.chunk_every(3)
    |> Enum.reduce(0, fn
        [one, two, _], sum -> sum + one + two
        [one, two], sum -> sum + one + two
        [one], sum -> sum + one
    end)
  end
end

Solution.minimum_cost([1,2,3]) |> IO.inspect(label: "Expected 5, got")
Solution.minimum_cost([6,5,7,9,2,2]) |> IO.inspect(label: "Expected 23, got")
Solution.minimum_cost([5,5]) |> IO.inspect(label: "Expected 10, got")
