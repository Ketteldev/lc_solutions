defmodule Solution do
  @spec find_min(nums :: [integer()]) :: integer()
  def find_min([a]), do: a
  def find_min([a, b]), do: min(a, b)
  def find_min(nums) do
    tums = List.to_tuple(nums)
    last = length(nums) - 1
    search(tums, 0, last, elem(tums, last))
  end

  defp search(tums, start, finish, last_num) do
    pos = start + finish |> div(2)
    check_val = elem(tums, pos)

    cond do
      check_val > last_num -> search(tums, pos + 1, finish, last_num)
      pos == 0 -> check_val
      pos - 1 >= 0 and check_val < elem(tums, pos - 1) -> check_val
      pos + 1 < tuple_size(tums) and check_val < elem(tums, pos + 1) -> search(tums, start, pos, last_num)
      true -> search(tums, pos + 1, finish, last_num)
    end
  end
end

Solution.find_min([3, 4, 5, 1, 2]) |> IO.inspect(label: "Expecting 1, got")
Solution.find_min([4, 5, 6, 7, 0, 1, 2]) |> IO.inspect(label: "Expecting 0, got")
Solution.find_min([11, 13, 15, 17]) |> IO.inspect(label: "Expecting 11, got")
Solution.find_min([2, 3, 4, 5, 1]) |> IO.inspect(label: "Expecting 1, got")
