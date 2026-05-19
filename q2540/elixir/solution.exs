defmodule Solution do
  @spec get_common(nums1 :: [integer()], nums2 :: [integer()]) :: integer()
  def get_common([x | _], [x | _]), do: x
  def get_common([x | _] = nums1, [y | tail]) when x > y, do: get_common(nums1, tail)
  def get_common([x | tail], [y | _] = nums2) when y > x, do: get_common(tail, nums2)
  def get_common(_, _), do: -1
end

Solution.get_common([1,2,3],[2,4]) |> IO.inspect(label: "Expecting 2, got")
Solution.get_common([1,2,3,6],[2,3,4,5]) |> IO.inspect(label: "Expecting 2, got")
Solution.get_common([1,2,3],[4,5,6]) |> IO.inspect(label: "Expecting -1, got")
