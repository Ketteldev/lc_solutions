defmodule Solution do
  @spec max_jumps(arr :: [integer], d :: integer) :: integer
  def max_jumps(arr, d) do
    tar = List.to_tuple(arr)
    len = length(arr)

    [{_value, index} | rest] = arr |> Enum.with_index() |> Enum.sort(&(&1 <= &2))

    Enum.reduce(rest, %{index => 0}, fn {v, i}, acc ->
      Enum.reduce(1..d, [], fn idx, a ->
        case Map.get(acc, idx) do
          nil -> [0 | a]
          value -> [1 + value | a]
        end
      end)
      |> Enum.max()
      |> then(&Map.put(acc, i, &1))
    end)
    |> IO.inspect()

    0
  end

  defp smallest_possible(v) when v < 0, do: 0
  defp smallest_possible(v), do: v
  defp highest_possible(v, l) when v >= l, do: l - 1
  defp highest_possible(v, _l), do: v
end

Solution.max_jumps([6,4,14,6,8,13,9,7,10,6,12], 2) |> IO.inspect(label: "Expected 4, got")
