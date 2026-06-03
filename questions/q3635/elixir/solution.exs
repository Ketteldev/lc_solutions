defmodule Solution do
  @moduledoc """
  This may look very familiar, because it is a copy and paste of question 3633.
  The question is a copy and paste, except that the title is II instead of I,
  and this one is medium difficulty instead of easy? My speculation is that
  there exists a potential time failure that wouldn't have failed in the first
  iteration of the problem? And perhaps because I solved it in O(n + m) on the
  first one, I was able to just copy and poaste it here? I'm not too sure.
  Alas, here we are with this one solved too, and no 'gotchas'.
  I'm not going to bother copying and pasting the examples, instead, I'm just
  going to ask that one refer to question 3633 for the code that will execute
  the solution and output the expectation.
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

  defp calc_time(used, s, d) do
    if used >= s, do: used + d, else: used + (s - used) + d
  end
end
