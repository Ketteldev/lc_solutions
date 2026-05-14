defmodule Solution do
  @spec is_good(nums :: [integer()]) :: boolean()
  def is_good(nums) do
    nums
    |> Enum.sort()
    |> Enum.with_index(1)
    |> good?()
  end

  defp good?([{last, idx}]), do: last == idx - 1
  defp good?([{expect, expect} | rest]), do: good?(rest)
  defp good?(_), do: false
end

[2, 1, 3] |> Solution.is_good() |> IO.inspect(label: "Expect `false`, got")
[3, 4, 4, 1, 2, 1] |> Solution.is_good() |> IO.inspect(label: "Expect `false`, got")
[1, 3, 3, 2] |> Solution.is_good() |> IO.inspect(label: "Expect `true`, got")
