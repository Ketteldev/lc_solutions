defmodule Solution do
  @spec find_the_common_prefix_array(a :: [integer()], b :: [integer()]) :: [integer()]
  def find_the_common_prefix_array(a, b), do: prefix(a, MapSet.new(), b, MapSet.new())

  defp prefix([], _, [], _), do: []
  defp prefix([a | a_tail], a_set, [b | b_tail], b_set) do
    a_set = MapSet.put(a_set, a)
    b_set = MapSet.put(b_set, b)
    [MapSet.intersection(a_set, b_set) |> MapSet.size() | prefix(a_tail, a_set, b_tail, b_set)]
  end
end

Solution.find_the_common_prefix_array([1,3,2,4],[3,1,2,4]) |> IO.inspect(label: "Expected [0,2,3,4], got")
Solution.find_the_common_prefix_array([2,3,1],[3,1,2]) |> IO.inspect(label: "Expected [0,1,3], got")
