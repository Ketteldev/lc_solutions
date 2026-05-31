defmodule Solution do
  @spec can_reach(arr :: [integer()], start :: integer()) :: boolean()
  def can_reach(arr, start) do
    tar = List.to_tuple(arr)
    last_idx = length(arr) - 1

    can_reach(tar, start, MapSet.new(), last_idx)
  end

  defp can_reach(tar, pos, idx_seen, last_idx) do
    value = elem(tar, pos)
    cond do
      value == 0 -> true

      # Been to this index? We didn't find 0, return false
      MapSet.member?(idx_seen, pos) -> false

      # Value added *and* subtracted from the index goes out of bounds, then cannot reach 0
      pos - value < 0 and pos + value > last_idx -> false

      # Value from position goes out of bounds, only go up in index
      pos - value < 0 -> can_reach(tar, pos + value, MapSet.put(idx_seen, pos), last_idx)

      # Value added to position goes out of bounds, only go down in index
      pos + value > last_idx -> can_reach(tar, pos - value, MapSet.put(idx_seen, pos), last_idx)

      # Check both subtract and add to position.
      true -> can_reach(tar, pos - value, MapSet.put(idx_seen, pos), last_idx) or can_reach(tar, pos + value, MapSet.put(idx_seen, pos), last_idx)
    end
  end
end

Solution.can_reach([4,4,1,3,0,3], 2) |> IO.inspect(label: "Expecting true, got")
Solution.can_reach([3,0,2,1,2], 2) |> IO.inspect(label: "Expecting false, got")
Solution.can_reach([4,2,3,0,3,1,2], 5) |> IO.inspect(label: "Expecting true, got")
