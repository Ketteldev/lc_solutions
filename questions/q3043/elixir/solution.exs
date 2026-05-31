defmodule Solution do
  @spec longest_common_prefix(arr1 :: [integer()], arr2 :: [integer()]) :: integer()
  def longest_common_prefix(arr1, arr2) do
    prefix_tree = build_prefix_tree(arr1)

    arr2
    |> Stream.map(&Integer.digits/1)
    |> Stream.map(&depth(&1, prefix_tree))
    |> Enum.max()
  end

  defp depth([], _prefix_tree), do: 0
  defp depth([digit | digits], prefix_tree) do
    case Map.get(prefix_tree, digit) do
      nil -> 0
      np when map_size(np) == 0 -> 1  # Empty map means digit found, do not continue
      next_prefix -> 1 + depth(digits, next_prefix)
    end
  end

  defp build_prefix_tree(array) do
    Enum.reduce(array, %{}, fn number, tree ->
      number |> Integer.digits() |> insert_digits(tree)
    end)
  end

  defp insert_digits([], tree), do: tree
  defp insert_digits([digit | digits], tree) do
    Map.update(tree, digit, insert_digits(digits, %{}), &insert_digits(digits, &1))
  end
end

Solution.longest_common_prefix([1, 10, 100], [1000]) |> IO.inspect(label: "Expecting 3, got")
Solution.longest_common_prefix([1, 2, 3], [4, 4, 4]) |> IO.inspect(label: "Expecting 0, got")
Solution.longest_common_prefix([102, 123, 167, 129, 293, 241], [294]) |> IO.inspect(label: "Expecting 2, got")
Solution.longest_common_prefix([1000], [100]) |> IO.inspect(label: "Expecting 3, got")
