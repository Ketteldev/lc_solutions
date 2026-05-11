defmodule Solution do
  @spec separate_digits(nums :: [integer()]) :: [integer()]
  def separate_digits(nums), do: Enum.flat_map(nums, &Integer.digits/1)
end
