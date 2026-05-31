defmodule Solution do
  def min_moves(nums, limit) do
    tums = List.to_tuple(nums)
    n = length(nums)
    num_pairs = div(n, 2)

    diff = Enum.reduce(0..(num_pairs - 1), %{}, fn i, acc ->
      a = elem(tums, i)
      b = elem(tums, n - 1 - i)

      sum = a + b
      min_sum = min(a, b) + 1
      max_sum = max(a, b) + limit

      acc
      |> Map.update(min_sum, -1, &(&1 - 1))
      |> Map.update(max_sum + 1, 1, &(&1 + 1))
      |> Map.update(sum, -1, &(&1 - 1))
      |> Map.update(sum + 1, 1, &(&1 + 1))
    end)

    diff
    |> Map.keys()
    |> Enum.filter(fn t -> t >= 2 and t <= 2 * limit end)
    |> Enum.sort()
    |> Enum.reduce({n, 0}, fn t, {moves, running_diff} ->
      new_running_diff = running_diff + Map.get(diff, t, 0)
      current_cost = n + new_running_diff
      {min(moves, current_cost), new_running_diff}
    end)
    |> elem(0)
  end
end

Solution.min_moves([37, 2, 9, 49, 58, 57, 48, 17], 58) |> IO.inspect(label: "Expecting 3, got")
