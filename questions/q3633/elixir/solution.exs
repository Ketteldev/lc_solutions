defmodule Solution do
  @moduledoc """
  Once again no gotchas in terms of submitting and passing all tests. However,
  I didn't solve this one in my brain right away. I had to really think through
  the fact that the best answer must include either the minimum of the land or
  minimum of the water.
  Once that was figured out, my first solution was to zip the arrays and sort.
  But that resultedi n O(n log n) runtime for the sort. But, I only need
  minimums and no sorted is required. So now it is O(2n + 2m) which is really
  just O(n + m).
  """

  @spec earliest_finish_time(land_start_time :: [integer], land_duration :: [integer], water_start_time :: [integer], water_duration :: [integer]) :: integer
  def earliest_finish_time(land_start_time, land_duration, water_start_time, water_duration) do
    min(
      find_min(land_start_time, land_duration) |> comb_min(water_start_time, water_duration),
      find_min(water_start_time, water_duration) |> comb_min(land_start_time, land_duration)
    )
  end

  defp find_min([last], [one]), do: last + one
  defp find_min([start | starts], [duration | durations]) do
    min(start + duration, find_min(starts, durations))
  end

  defp comb_min(ride, [last], [one]), do: calc_time(ride, last, one)
  defp comb_min(ride, [start | starts], [duration | durations]) do
    calc_time(ride, start, duration) |> min(comb_min(ride, starts, durations))
  end

  # If no ride is ready when we finish the first, add the wait time.
  defp calc_time(used, s, d) do
    if used >= s, do: used + d, else: used + (s - used) + d
  end
end

Solution.earliest_finish_time([2,8],[4,1],[6],[3]) |> IO.inspect(labeL: "Expected 9, got")
