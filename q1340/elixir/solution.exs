defmodule Solution do
  @moduledoc """
  First try. No "gotcha" edge cases today, which felt really good to accomplish.
  Took a little extra time to think about strategy, and just thought about
  solving for local minimums, which is 1. Then, climbing up in value I could add
  steps for each one that the index can reach. Since they cannot even jump over
  higher points, we can just immediately stop if a pillar is unreachable.

  My general strategy is to:
    - Sort by value first, index second, so I go in order of indices that are
      the lowest points and climbing upwards.
    - Then, iterating over the list, checking left and right direction for valid
      jumps, stopping immediately if invalid and not checking further.
    - Then, checking the memory map, for previously discovered scores, and
      taking the maximum from those and adding one to it for the current
      position, then storing that in the memory map.
    - Then, taking the max of the maxes.

  I believe this falls under the paradigm of Dynamic Programming, solving the
  smallest iteration and building up.

  Also, it isn't the prettiest code, but it works well.
  """
  @spec max_jumps(arr :: [integer], d :: integer) :: integer
  def max_jumps(arr, d) do
    tar = List.to_tuple(arr)
    len = length(arr)

    [{_value, index} | rest] = arr |> Enum.with_index() |> Enum.sort(&(&1 <= &2))

    Enum.reduce(rest, %{index => 1}, fn {_v, i}, acc ->
      left = Enum.reduce_while(-1..(-1 * d)//-1, [], fn delta, acc ->
        checkdex = i + delta

        if checkdex > -1 and elem(tar, checkdex) < elem(tar, i) do
          {:cont, [checkdex | acc]}
        else
          {:halt, acc}
        end
      end)

      left_and_right = Enum.reduce_while(1..d, left, fn delta, acc ->
        checkdex = i + delta

        if checkdex < len and elem(tar, checkdex) < elem(tar, i) do
          {:cont, [checkdex | acc]}
        else
          {:halt, acc}
        end
      end)

      Enum.reduce(left_and_right, [1], fn idx, a ->
        case Map.get(acc, idx) do
          nil -> [1 | a]
          value -> [1 + value | a]
        end
      end)
      |> Enum.max()
      |> then(&Map.put(acc, i, &1))
    end)
    |> Map.values()
    |> Enum.max()
  end
end

Solution.max_jumps([6,4,14,6,8,13,9,7,10,6,12], 2) |> IO.inspect(label: "Expected 4, got")
