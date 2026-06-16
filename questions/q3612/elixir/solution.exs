defmodule Solution do
  @moduledoc """
  No gotchas today. Originally I solved it with charlists, but then compared
  my solution time to solving it with a string. Now this could just be the
  LeetCode environment, but I got 112ms with charlists, and 8ms with Strings.
  I think generally speaking, string processing, especially with lots of end-of-
  string manipulation, will be faster than end of list processing.
  """

  @spec process_str(string :: String.t) :: String.t
  def process_str(string), do: process_str(string, "")

  defp process_str("", result), do: result
  defp process_str("*" <> rest, ""), do: process_str(rest, "")
  defp process_str("*" <> rest, result), do: process_str(rest, String.slice(result, 0..-2//1))
  defp process_str("#" <> rest, result), do: process_str(rest, result <> result)
  defp process_str("%" <> rest, result), do: process_str(rest, String.reverse(result))
  defp process_str(<<char::binary-size(1), rest::binary>>, result) do
    process_str(rest, result <> char)
  end
end

Solution.process_str("a#b%*") |> IO.inspect(label: "Expeacted \"ba\", got")
Solution.process_str("z*#") |> IO.inspect(label: "Expeacted \"\", got")
Solution.process_str("a#bde%e#e*ds*%*") |> IO.inspect(label: "Expeacted \"deaabdeeaabd\", got")
