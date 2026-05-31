defmodule Solution do
  @moduledoc """
  This one I did not solve as the daily, it was yesterday's. However, I still
  wanted to solve it because it was a huge learning experience. Despite having
  the right intuition to solve it, with a sliding window (although, I was doing
  it backwards with a leading window instead of a trailing window), I couldn't
  figure out why I kept time-failing.

  So, I endeavored to learn about put_elem/3, and how tuples really work within
  Elixir. I knew about immutability, but I didn't really think far enough to
  consider the O(n) time to write a value to the tuple. Reading is O(1), so I
  made the silly mistake of _assuming_ writing would be. Of course not, it has
  to rewrite the whole tuple for one value.

  Enter :array from Erlang. This is where I learned about its use of a "10-ary"
  tree structure of size 10 tuples. So reads and writes are, in base 10,
  O(log n). This was able to satisfy the much larger and longer edge test cases
  that were presented in this problem.
  """

  @spec can_reach(s :: String.t, min_jump :: integer, max_jump :: integer) :: boolean
  def can_reach(s, min_jump, max_jump) do
    n = String.length(s)
    dp = String.to_charlist(s) |> Enum.map(&(&1 == ?0)) |> :array.from_list()
    dp = :array.set(0, true, dp)

    Enum.reduce(1..(n - 1), {dp, 0}, fn i, {dp_acc, pre} ->
      new_pre =
        if i >= min_jump do
          val = :array.get(i - min_jump, dp_acc)
          pre + if val, do: 1, else: 0
        else
          pre
        end

      new_pre =
        if i > max_jump do
          val = :array.get(i - max_jump - 1, dp_acc)
          new_pre - if val, do: 1, else: 0
        else
          new_pre
        end

      current_dp_i = :array.get(i, dp_acc)
      new_dp_i = current_dp_i and (new_pre > 0)

      {:array.set(i, new_dp_i, dp_acc), new_pre}
    end)
    |> elem(0)
    |> then(&:array.get(n - 1, &1))
  end
end

Solution.can_reach("011010", 2, 3) |> IO.inspect(label: "Expected `true`, got")
Solution.can_reach("01101110", 2, 3) |> IO.inspect(label: "Expected `false`, got")
