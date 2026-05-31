defmodule Solution do
  @moduledoc """
  There was one gotcha today. The mass of `1` and asteroids `[1]`. Originally
  I did `mass > asteroid`, but it needed to be `mass >= asteroid`. Woops.
  """

  @spec asteroids_destroyed(mass :: integer, asteroids :: [integer]) :: boolean
  def asteroids_destroyed(mass, asteroids) do
    ad(mass, asteroids, [])
  end

  defp ad(mass, [], []), do: true
  defp ad(mass, [], leftovers) do
    if Enum.min(leftovers) > mass do
      false
    else
      ad(mass, leftovers, [])
    end
  end
  defp ad(mass, [ass | asses], leftovers) do
    if mass >= ass do
      ad(mass + ass, asses, leftovers)
    else
      ad(mass, asses, [ass | leftovers])
    end
  end
end

Solution.asteroids_destroyed(10, [3,9,19,5,21]) |> IO.inspect(label: "Expected true, got")
Solution.asteroids_destroyed(5, [4,9,23,4]) |> IO.inspect(label: "Expected false, got")
