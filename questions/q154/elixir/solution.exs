defmodule Solution do
  @spec find_min(nums :: [integer()]) :: integer()
  def find_min(nums), do: nums |> List.to_tuple() |> search(0, length(nums) - 1)

  defp search(tums, idx, idx), do: elem(tums, idx)
  defp search(tums, left, right) do
    mid = left + right |> div(2)

    cond do
      elem(tums, mid) > elem(tums, right) -> search(tums, mid + 1, right)
      elem(tums, mid) < elem(tums, right) -> search(tums, left, mid)
      true -> search(tums, left, right - 1)
    end
  end
end

[1, 3, 5] |> Solution.find_min() |> IO.inspect(label: "Expected 1, got")
[2, 2, 2, 0, 1] |> Solution.find_min() |> IO.inspect(label: "Expected 0, got")
[0, 1, 4, 4, 5, 6, 7] |> Solution.find_min() |> IO.inspect(label: "Expected 0, got")
[4, 4, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4] |> Solution.find_min() |> IO.inspect(label: "Expected 1, got")
[4, 4, 4, 4, 4, 4, 4, 4, 5, 6, 1, 2, 3, 4, 4] |> Solution.find_min() |> IO.inspect(label: "Expected 1, got")
[4, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 4, 4] |> Solution.find_min() |> IO.inspect(label: "Expected 1, got")
[1, 3, 3] |> Solution.find_min() |> IO.inspect(label: "Expected 1, got")
[1, 1, 1] |> Solution.find_min() |> IO.inspect(label: "Expected 1, got")
