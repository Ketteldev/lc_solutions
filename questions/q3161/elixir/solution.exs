defmodule Solution do
  @moduledoc """
  After a few attempts, and took care of some edge cases. The biggest one was
  the off by one error (classic). However, there was also `boundary` < `size`
  that I didn't account for that got me.

  After tackling those, I did not get credit for LeetCode problem solution
  because this solution timed out.

  After doing more research, the next step I would take would be to keep track
  of gaps, so that I can look within the boundary for the biggest gap and see
  if the `size` fits in that largest gap. This instead of doing this sliding
  window that I am using to place blocks.
  """

  @spec get_results(queries :: [[integer]]) :: [boolean]
  def get_results(queries) do
    Enum.reduce(queries, {[], %{}}, fn
      [1, location], {results, obstacles} -> {results, Map.put(obstacles, location, true)}
      [2, boundary, size], {results, obstacles} -> {[fits?(boundary, size, obstacles) | results], obstacles}
    end)
    |> elem(0)
    |> Enum.reverse()
  end

  defp fits?(boundary, size, _obstacles) when boundary < size, do: false
  defp fits?(boundary, size, obstacles) do
    count = Enum.count(0..(size-2), &Map.get(obstacles, &1))
    Enum.reduce_while((size-1)..(boundary-1), {false, count}, fn idx, {_, c} ->
      c = c + if Map.get(obstacles, idx - (size-1)), do: -1, else: 0
      c = c + if Map.get(obstacles, idx), do: 1, else: 0
      if c == 0, do: {:halt, {true, 0}}, else: {:cont, {false, c}}
    end)
    |> elem(0)
  end
end

Solution.get_results([[2,5,1],[1,3],[2,6,4]]) |> IO.inspect(label: "Expected [true, false], got")
Solution.get_results([[1,2],[2,3,3],[2,3,1],[2,2,2]]) |> IO.inspect(label: "Expected [false, true, true], got")
Solution.get_results([[1,7],[2,7,6],[1,2],[2,7,5],[2,7,6]]) |> IO.inspect(label: "Expected [true, true, false], got")
