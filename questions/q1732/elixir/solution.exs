defmodule Solution do
  @moduledoc """
  A simple one, but again, far more entertaining than the questions that are in
  the 3000s.
  """

  @spec largest_altitude(gain :: [integer()]) :: integer()
  def largest_altitude(gain) do
    Enum.reduce(gain, {0, 0}, fn delta, {current, highest} ->
      next = current + delta
      {next, max(next, highest)}
    end)
    |> elem(1)
  end
end

Solution.largest_altitude([-5,1,5,0,-7]) |> IO.inspect(label: "Expected 1, got")
Solution.largest_altitude([-4,-3,-2,-1,4,3,2]) |> IO.inspect(label: "Expected 0, got")
