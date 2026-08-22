defmodule Solution do
  @moduledoc """
  Pretty straight forward problem. Just take the digits, then sum them and
  product them, then take the sum of the sum and product and see if it divides
  the original number with no remainder.

  This is a silly, single-loop iteration, to get the sum and product at the same
  time. But, the constraints were 10^6, so in the worst case scenario, there
  would be 6 digits. Looping 12 elements isn't the worst thing in the world, so
  I originally used Enum.sum/1 and Enum.product/1. But, as a though experiement
  ended with this solution, as if it could get worse than a list of 6 elements.
  """
  @spec check_divisibility(n :: integer) :: boolean
  def check_divisibility(n) do
    Integer.digits(n)
    |> Enum.reduce({0,1}, fn digit, {sum, product} ->
      {sum + digit, product * digit}
    end)
    |> then(fn {s, p} -> rem(n, s+p) == 0 end)
  end
end

Solution.check_divisibility(99) |> IO.inspect(label: "Expected `true`, got")
Solution.check_divisibility(23) |> IO.inspect(label: "Expected `false`, got")
