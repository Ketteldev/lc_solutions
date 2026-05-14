defmodule Solution do
  @spec is_good(nums :: [integer()]) :: boolean()
  def is_good([1, 1]), do: true
  def is_good(nums) do
    double = length(nums) - 1

    seen = Enum.frequencies(nums)

    seen[double] == 2 and Enum.all?(1..(double-1), &(seen[&1] == 1))
  end
end

[2, 1, 3] |> Solution.is_good() |> IO.inspect(label: "Expect `false`, got")
[3, 4, 4, 1, 2, 1] |> Solution.is_good() |> IO.inspect(label: "Expect `false`, got")
[1, 3, 3, 2] |> Solution.is_good() |> IO.inspect(label: "Expect `true`, got")
[1, 1] |> Solution.is_good() |> IO.inspect(label: "Expect `true`, got")
