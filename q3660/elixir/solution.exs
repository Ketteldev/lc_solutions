defmodule Solution do
  @spec max_value(nums :: [integer]) :: [integer]
  def max_value(nums) do
    nums
    |> local_max_vals()
    |> apply_local_max()
    |> Enum.map(fn [lm | _] = list -> List.duplicate(lm, Enum.count(list)) end)
    |> Enum.reverse()
    |> List.flatten()
  end

  defp apply_local_max([curr | rest]) do
    case append(rest, curr) do
      {new_curr, []} ->
        new_curr

      {new_curr, remaining} ->
        stuffs = apply_local_max(remaining)
        [new_curr | stuffs]
    end
  end

  defp append([], curr), do: {[curr], []}
  defp append([[sub_max | _] = list | rest], curr) do
    minimum = Enum.min(curr)
    if sub_max > minimum do
      append(rest, curr ++ list) 
    else
      {curr, [list | rest]}
    end
  end

  defp local_max_vals([]), do: []
  defp local_max_vals(nums) do
    {lower, upper} = Enum.split(nums, find_max_loc(nums))

    [upper | local_max_vals(lower)]
  end

  defp find_max_loc(list) do
    list |> Enum.with_index() |> Enum.max_by(fn {val, _idx} -> val end) |> elem(1)
  end
end
