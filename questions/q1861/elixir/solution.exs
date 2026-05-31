defmodule Solution do
  @spec rotate_the_box(box_grid :: [[char]]) :: [[char]]
  def rotate_the_box(box_grid) do
    box_grid
    |> rotate()
    |> Enum.map(&Enum.reverse/1)
  end

  defp rotate([last_row]) do
    last_row
    |> horizontal_gravity()
    |> Enum.map(&[&1])
  end
  defp rotate([row | remaining_rows]) do
    remaining_rows
    |> rotate()
    |> add_column(horizontal_gravity(row))
  end

  defp add_column([last_column], [last_symbol]) do
    [[last_symbol | last_column]]
  end
  defp add_column([col | rest], [symbol | remaining]) do
    [[symbol | col] | add_column(rest, remaining)]
  end
  defp add_column(_, _), do: [[]]

  defp horizontal_gravity(row) do
    row
    |> Enum.reduce([[]], fn
      ?#, [curr | tail] -> [[?# | curr] | tail]
      ?., [curr | tail] -> [[?. | curr] | tail]
      ?*, acc -> [[] | acc]
    end)
    |> Enum.map(fn section ->
      section |> Enum.frequencies() |> Enum.flat_map(fn {symbol, count} -> List.duplicate(symbol, count) end) |> Enum.reverse()
    end)
    |> replace_obstacles()
  end

  defp replace_obstacles([last]), do: last
  defp replace_obstacles([stones | rest]) do
    replace_obstacles(rest) ++ [?* | stones]
  end
end
