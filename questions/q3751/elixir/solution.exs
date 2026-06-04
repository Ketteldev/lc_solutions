defmodule Solution do
  @moduledoc """
  No gotchas tonight again. `Integer.digits/1` made this quite easy, because
  I didn't have to worry about modulus and keeping track of the previous digit.
  I was able to just compare directly for peaks and valleys as I ran through the
  range with `Enum.reduce/3`
  """

  @spec total_waviness(num1 :: integer, num2 :: integer) :: integer
  def total_waviness(num1, num2) do
    Enum.reduce(num1..num2, 0, &(&2 + waviness(&1)))
  end

  defp waviness([]), do: 0
  defp waviness([_x]), do: 0
  defp waviness([_x, _y]), do: 0
  defp waviness([x, y, z | rest]) when y > x and y > z, do: 1 + waviness([y, z | rest])
  defp waviness([x, y, z | rest]) when y < x and y < z, do: 1 + waviness([y, z | rest])
  defp waviness([_drop | rest]), do: waviness(rest)
  defp waviness(make_digits) do
    make_digits |> Integer.digits() |> waviness()
  end
end

Solution.total_waviness(120, 130) |> IO.inspect(label: "Expected 3, got")
Solution.total_waviness(198, 202) |> IO.inspect(label: "Expected 3, got")
Solution.total_waviness(4848, 4848) |> IO.inspect(label: "Expected 2, got")
