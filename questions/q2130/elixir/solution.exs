# Definition for singly-linked list.
#
# defmodule ListNode do
#   @type t :: %__MODULE__{
#           val: integer,
#           next: ListNode.t() | nil
#         }
#   defstruct val: 0, next: nil
# end

defmodule Solution do
  @moduledoc """
  So, this was a nifty learning experience. This was not the way that I solved
  it. Despite O(5n) == O(n) in time complexity, this still iterates once,
  compared to my 5 iterations.
  My original solution, although no "gotchas," made a list, got the count, split
  it in half, zipped, and found the max sum.
  This was a learning experience, to have one pointer skip a node each time,
  going twice as fast, resulting in half the list iterated by the slow track,
  and being at the half way point in the linked list. So, now I have a list of
  values in reverse order from the front of the linked list, which will match
  perfectly when iterating the back half to find their twin sum.
  """

  @spec pair_sum(head :: ListNode.t | nil) :: integer
  def pair_sum(head) do
    {back_half_of_list, listified_front} = find_halfway(head, head, [])

    max_twin(back_half_of_list, listified_front)
  end

  defp find_halfway(back_half_start, nil, backwards_first_half), do: {back_half_start, backwards_first_half}
  defp find_halfway(%{val: val, next: next}, fast, stack) do
    find_halfway(next, fast.next.next, [val | stack])
  end

  defp max_twin(%{val: val, next: nil}, [x]), do: val + x
  defp max_twin(%{val: val, next: next}, [x | stack]) do
    max(val + x, max_twin(next, stack))
  end
end
