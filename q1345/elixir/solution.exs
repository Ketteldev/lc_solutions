defmodule Solution do
  @spec min_jumps(arr :: [integer()]) :: integer()
  def min_jumps([_only]), do: 0
  def min_jumps(arr) do
    jumps = Enum.with_index(arr) |> Enum.reduce(%{}, fn {val, idx}, j ->
      Map.update(j, val, [idx], &[idx | &1])
    end)

    bfs([0], MapSet.new(), jumps, List.to_tuple(arr), length(arr) - 1)
  end

  defp bfs(queue, seen, jumps, tar, target) do
    if target in queue do
      0
    else
      {next_queue, next_seen, next_jumps} =
        Enum.reduce(queue, {[], seen, jumps}, fn position, {q_acc, s_acc, j_acc} ->
          jump_value = elem(tar, position)

          neighbors =
            [position - 1, position + 1 | Map.get(j_acc, jump_value, [])]
            |> Enum.filter(fn pos ->
              pos >= 0 and pos <= target and not MapSet.member?(s_acc, pos)
            end)

          s_acc = Enum.reduce(neighbors, s_acc, &MapSet.put(&2, &1))

          j_acc = Map.delete(j_acc, jump_value)

          {neighbors ++ q_acc, s_acc, j_acc}
        end)

      1 + bfs(next_queue, next_seen, next_jumps, tar, target)
    end
  end
end

[68,-94,-44,-18,-1,18,-87,29,-6,-87,-27,37,-57,7,18,68,-59,29,7,53,-27,-59,18,-1,18,-18,-59,-1,-18,-84,-20,7,7,-87,-18,-84,-20,-27]
|> Solution.min_jumps()
|> IO.inspect(label: "Expected 5, got")

[7,6,9,6,9,6,9,7]
|> Solution.min_jumps()
|> IO.inspect(label: "Expected 1, got")

[7]
|> Solution.min_jumps()
|> IO.inspect(label: "Expected 0, got")

[100,-23,-23,404,100,23,23,23,3,404]
|> Solution.min_jumps()
|> IO.inspect(label: "Expected 3, got")
