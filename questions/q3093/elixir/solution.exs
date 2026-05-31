defmodule Solution do
  @moduledoc """
  Today was definitely a "Look it up, and just learn" type of day.

  The first lesson was that this seemingly "obscure" problem was not that
  obscure afterall. At the very least, the subproblem of finding the longest
  suffix appears to be relevant to DNS. I am not sure how returning a list of
  indices for the matches would apply beyond that though.

  The second lesson was implementing a little more complex of a Trie. Though I
  have implemented Tries before, and in Elixir, this one needed to track string
  length and index in addition to longest suffix, so that it could resolve
  tie-breakers.

  The result was a lot of learning today. Again, I fully looked up the solution
  to get assistance with solving such a problem as this.
  """

  @spec string_indices(wordsContainer :: [String.t()], wordsQuery :: [String.t()]) :: [integer()]
  def string_indices(wordsContainer, wordsQuery) do
    trie =
      wordsContainer
      |> Stream.with_index()
      |> Enum.reduce(%{}, fn {word, idx}, acc ->
        insert(acc, String.reverse(word), idx, String.length(word))
      end)

    Enum.map(wordsQuery, &find_best(trie, String.reverse(&1)))
  end

  defp insert(node, "", index, len), do: update_best(node, index, len)
  defp insert(node, <<char::utf8, rest::binary>>, index, len) do
    node = update_best(node, index, len)
    children = Map.get(node, :children, %{})
    child = Map.get(children, char, %{})
    updated_child = insert(child, rest, index, len)
    Map.put(node, :children, Map.put(children, char, updated_child))
  end

  defp find_best(%{best: best}, ""), do: elem(best, 0)
  defp find_best(%{}, ""), do: nil
  defp find_best(%{best: best} = node, <<char::utf8, rest::binary>>) do
    node
    |> Map.get(:children, %{})
    |> Map.get(char)
    |> case do
      nil -> elem(best, 0)
      child -> find_best(child, rest)
    end
  end

  defp update_best(node, index, len) do
    case Map.get(node, :best) do
      nil ->
        Map.put(node, :best, {index, len})

      {best_idx, best_len} ->
        if len < best_len or (len == best_len and index < best_idx) do
          Map.put(node, :best, {index, len})
        else
          node
        end
    end
  end
end
