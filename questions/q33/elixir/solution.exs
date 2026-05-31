defmodule Solution do
  @moduledoc """
  This marks the beginning of adding doc-blocks to these solutions. That way, I
  can note my "gotchas."

  The following edge cases got me:
  CASE: nums - [1, 3]  target - 0
  RESOLUTION: Swap `value` and `target` order in search/4

  CASE: nums - [1, 3]  target - 1
  RESOLUTION: Call `search/4` as a normal binary search

  CASE: nums - [5, 1, 3], target - 0
  RESOLUTION: Add a condition to check that the value is lower than the minimum

  Solution in English:
    Finding the index of the minimum using binary search will result in O(log n).
    Then, after comparing the target to the first value in the list, we can
    binary search in the part of the list that the target could exist in, and
    return -1 if the target is not present.
  """

  @spec search(nums :: [integer], target :: integer) :: integer
  def search([only], only), do: 0
  def search([_only], _target), do: -1
  def search([target | _] = _nums, target), do: 0
  def search([first | _] = nums, target) do
    tums = List.to_tuple(nums)
    upper = length(nums) - 1
    min_idx = find_min_idx(tums, 0, upper)

    cond do
      elem(tums, min_idx) > target -> -1

      # Not rotated, just binary search
      min_idx == 0 -> search(tums, 0, upper, target) 

      # Target in rotated part
      target < first -> search(tums, min_idx, upper, target)

      # Target in non-rotated part
      true -> search(tums, 0, min_idx - 1, target)
    end
  end

  defp find_min_idx(_tums, idx, idx), do: idx
  defp find_min_idx(tums, lower, upper) do
    mid = div(lower + upper, 2)

    if elem(tums, mid) > elem(tums, upper) do
      find_min_idx(tums, mid + 1, upper)
    else
      find_min_idx(tums, lower, mid)
    end
  end

  defp search(tums, same, same, target) do
    if elem(tums, same) == target, do: same, else: -1
  end
  defp search(tums, lower, upper, target) do
    mid = div(lower + upper, 2)
    value = elem(tums, mid)
    cond do
      value == target -> mid
      target > value -> search(tums, mid + 1, upper, target)
      target < value -> search(tums, lower, mid, target)
    end
  end
end
