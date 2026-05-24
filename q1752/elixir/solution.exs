defmodule Solution do
  @moduledoc """
  I first tried to just go start to finish and look for 2 things out place,
  however, that wasn't going to work because the array could just not be
  sorted.
  So instead I went for the more naive approach, to start at the minimum value
  and verify that its neighbor was the same or bigger, wrapping around using
  modulus math.

  So, the edge cases that got me this time:
  CASE: [2, 1, 3, 4]
  RESOLUTION: Don't just count if there are 2 instances of the left neighbor
  being bigger, and returing `true` if less than 2. This is just not sorted.

  CASE: [6, 10, 6]
  RESOLUTION: Check if the minimum is wrapped before starting to iterate for
  ascending order.
  """

  @spec check(nums :: [integer]) :: boolean
  def check([_only]), do: true
  def check(nums) do
    minimum = Enum.min(nums)
    mindex = Enum.find_index(nums, &(&1 == minimum))
    len = length(nums)
    tums = List.to_tuple(nums)

    mindex = check_min_wraps(tums, mindex, len - 1)

    Enum.reduce_while(mindex..(mindex + len - 2), true, fn idx, _ ->
      value = elem(tums, rem(idx, len))
      if value > elem(tums, rem(idx + 1, len)) do
        {:halt, false}
      else
        {:cont, true}
      end
    end)
  end

  defp check_min_wraps(tums, 0, last_idx) do
    minimum = elem(tums, 0)
    if elem(tums, last_idx) == minimum do
      Enum.reduce_while(last_idx..0, 0, fn idx, lowest ->
        if elem(tums, idx) != minimum, do: {:halt, idx + 1}, else: {:cont, lowest}
      end)
    else
      0
    end
  end
  defp check_min_wraps(_, idx, _), do: idx
end
