defmodule Solution do
  @moduledoc """
  Definitely no gotchas today. Pretty simple question, to just sum the digits of
  each number in the list and then find the minimum among them.
  I did not benchmark for something like this, though it would be curious to see
  how the many possible solutions would perform. I only debated within my own
  head to use `Stream.map/2` into `Enum.min/1` vs using `Enum.reduce/3` and
  keeping track of the minimum within that.
  """

  @spec min_element(nums :: [integer]) :: integer
  def min_element(nums) do
    nums
    |> Stream.map(&(Integer.digits(&1) |> Enum.sum()))
    |> Enum.min()
  end
end

Solution.min_element([10, 11, 12, 13]) |> IO.inspect(label: "Expecting 1, got")
Solution.min_element([1, 2, 3, 4]) |> IO.inspect(label: "Expecting 1, got")
Solution.min_element([199, 19, 999]) |> IO.inspect(label: "Expecting 10, got")
