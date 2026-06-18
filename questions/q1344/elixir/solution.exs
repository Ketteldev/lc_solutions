defmodule Solution do
  @moduledoc """
  I did not know that there was a simple way to calculate the angle of a clock
  with a difference of products based on the hour and minutes. I definitely
  looked that one up.
  At any rate, there were no 'gotchas' for this one because the math is pretty
  simple.
  """

  @spec angle_clock(hour :: integer, minutes :: integer) :: float
  def angle_clock(hour, minutes) do
    if (angle = abs(30 * hour - 5.5 * minutes)) > 180 do
      360 - angle
    else
      angle
    end
  end
end

Solution.angle_clock(12, 30) |> IO.inspect(label: "Expected 165.0, got")
Solution.angle_clock(3, 30) |> IO.inspect(label: "Expected 75.0, got")
Solution.angle_clock(3, 15) |> IO.inspect(label: "Expected 7.5, got")
