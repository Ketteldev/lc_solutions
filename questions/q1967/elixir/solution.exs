defmodule Solution do
  @spec num_of_strings(patterns :: [String.t], word :: String.t) :: integer
  def num_of_strings(patterns, word) do
    Enum.count(patterns, &String.contains?(word, &1))
  end
end

Solution.num_of_strings(["a","abc","bc","d"], "abc") |> IO.inspect(label: "Expected 3, got:")
Solution.num_of_strings(["a","b","c"], "aaaaabbbbb") |> IO.inspect(label: "Expected 2, got:")
Solution.num_of_strings(["a","a","a"],"ab") |> IO.inspect(label: "Expected 3, got:")
