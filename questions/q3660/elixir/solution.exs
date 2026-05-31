defmodule Solution do
  @spec max_value(nums :: [integer]) :: [integer]
  def max_value(nums) do
    tuple_nums = List.to_tuple(nums)

    prefix_max =
      nums
      |> Enum.scan(fn val, acc -> max(val, acc) end)
      |> List.to_tuple()

    Enum.reduce((tuple_size(tuple_nums) - 1)..0, {[], Enum.max(nums), :infinity}, fn i, {acc, next_ans, suffix_minimum} ->
      current_prefix_max = elem(prefix_max, i)
      value_at_i = elem(tuple_nums, i)

      max_reachable_from_i =
        if greater_than?(current_prefix_max, suffix_minimum) do
          next_ans
        else
          current_prefix_max
        end

      updated_suffix_minimum = min_val(value_at_i, suffix_minimum)

      {[max_reachable_from_i | acc], max_reachable_from_i, updated_suffix_minimum}
    end)
    |> elem(0)
  end

  defp greater_than?(_val, :infinity), do: false
  defp greater_than?(val, num), do: val > num

  defp min_val(val, :infinity), do: val
  defp min_val(val, num), do: min(val, num)
end
