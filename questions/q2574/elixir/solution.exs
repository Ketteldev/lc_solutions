defmodule Solution do
  @moduledoc """
  No gotchas today. I had a compile error when I would have submitted a bad
  solution. But, then I thought about it a little more to submit something
  cleaner.
  """

  @spec left_right_difference(nums :: [integer]) :: [integer]
  def left_right_difference([_only]), do: [0]
  def left_right_difference(nums), do: lr_diff(nums, 0, Enum.sum(nums) - hd(nums))

  defp lr_diff([_last], left, _right), do: [left]
  defp lr_diff([x, y | rest], left, right) do
    [abs(left - right) | lr_diff([y | rest], left + x, right - y)]
  end
end

Solution.left_right_difference([10,4,8,3]) |> IO.inspect(label: "Expected [15, 1, 11, 22], got")
Solution.left_right_difference([1]) |> IO.inspect(label: "Expected [0], got")
Solution.left_right_difference([2, 7]) |> IO.inspect(label: "Expected [7, 2], got")
