defmodule Solution do
  @moduledoc """
  This one seemed borderline 'easy' because it felt too straight forward.
  Able to get it first try, with no gotchas, and no accidental compiler errors.
  Not sure if there is a smoother experience with less arrays.
  """

  @spec pivot_array(nums :: [integer], pivot :: integer) :: [integer]
  def pivot_array(nums, pivot) do
    Enum.reduce(nums, {[], [], []}, fn num, {lower, pivots, upper} ->
      cond do
        num < pivot -> {[num | lower], pivots, upper}
        num > pivot -> {lower, pivots, [num | upper]}
        true -> {lower, [num | pivots], upper}
      end
    end)
    |> then(fn {lower, pivots, upper} ->
      Enum.reverse(lower) ++ pivots ++ Enum.reverse(upper)
    end)
  end
end

Solution.pivot_array([9, 12, 5, 10, 14, 3, 10], 10) |> IO.inspect(label: "Expected [9, 5, 3, 10, 10, 12, 14], got")
Solution.pivot_array([-3, 4, 3, 2], 2) |> IO.inspect(label: "Expected [-3, 2, 4, 3], got")
