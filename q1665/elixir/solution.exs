defmodule Solution do
  @spec minimum_effort(tasks :: [[integer()]] :: integer()
  def minimum_effort(tasks) do
    tasks
    |> Enum.sort_by(fn [actual, minimum] -> actual - minimum end)
    |> Enum.reduce({0, 0}, fn [actual, minimum], {answer, current} ->
      if current < minimum do
        {answer + minimum - current, minimum - actual}
      else
        {answer, current - actual}
      end
    end)
    |> elem(0)
  end
end
