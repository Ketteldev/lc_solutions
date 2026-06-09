defmodule Solution do
  @moduledoc """
  This one was a lot of words with no real value. The examples were even red
  herrings in the grand scheme of things. Maybe LeetCode is dropping off for
  having good challenges.
  The goal of this one was to create `k` subarrays from `nums` that generates
  the maximum difference between the largest element and the smallest element.
  However, subarrays can overlap, or even be repeated. Well, that just means
  take the largest element in `nums`, subtract the smallest element, then
  multiply by `k` to get result.
  Bam, `O(n)` runtime and `O(1)` space complexity.
  Definitely no 'gotchas' tonight after that 10-second solution.
  Honestly, I was asking LeetCode to have a test that failed my solution. I
  wanted to be wrong in my assumption, so that I could actually do some thinking
  tonight. Alas, here we are. Oh well.
  """

  @spec max_total_value(nums :: [integer], k :: integer) :: integer
  def max_total_value(nums, k) do
    nums
    |> Enum.min_max()
    |> then(fn {l, h} -> (h - l) * k end)
  end
end

Solution.max_total_value([1,3,2], 2) |> IO.inspect(label: "Expected 4, got")
Solution.max_total_value([4,2,5,1], 3) |> IO.inspect(label: "Expected 12, got")
