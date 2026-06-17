defmodule Solution do
  @moduledoc """
  I took yesterday's code, and tried to apply it to today, and just capture the
  char and move on. But it wasn't that simple, because now the strings could be
  crazy size up to 10^15.
  I didn't even want to begin to try and think about how to process information
  without being able to even store it. So I turned to a guide to try and figure
  out what solutions were out there for solving something like this.
  This is what I brought to. This idea of keeping track of sizes, and then
  reverse engineering the character. I am going to have to revisit this with a
  visualization so I understand what is acutally taking place.
  """

  @spec process_str(s :: String.t(), k :: integer) :: String.t()
  def process_str(s, k) do
    chars = String.to_charlist(s)
    sizes = track_sizes(chars, 0, [])
    final_size = if sizes == [], do: 0, else: hd(sizes)

    if k >= final_size do
      ?.
    else 
      find_kth(Enum.reverse(chars), k, sizes)
    end
  end

  defp track_sizes([], _sz, acc), do: acc
  defp track_sizes([c | rest], sz, acc) do
    new_sz = case c do
      ?* -> max(0, sz - 1)
      ?# -> sz * 2
      ?% -> sz
      _  -> sz + 1
    end
    track_sizes(rest, new_sz, [new_sz | acc])
  end

  defp find_kth([], _k, _sizes), do: ?.
  defp find_kth([c | rest], k, [sz | sizes]) do
    case c do
      ?* -> find_kth(rest, k, sizes)
      ?# ->
        half = div(sz, 2)
        new_k = if k >= half, do: k - half, else: k
        find_kth(rest, new_k, sizes)
      ?% -> find_kth(rest, sz - 1 - k, sizes)
      _  ->
        if k == sz - 1, do: c, else: find_kth(rest, k, sizes)
    end
  end
end

Solution.process_str("a#b%*",1) |> IO.inspect(label: "Expected #{inspect(?a)}, got")
Solution.process_str("cd%#*#",3) |> IO.inspect(label: "Expected #{inspect(?d)}, got")
Solution.process_str("z*#",0) |> IO.inspect(label: "Expected #{inspect(?.)}, got")
Solution.process_str("##zly#f###a#hl#qw%#h#g#x##%vd*e#xgig##%fsr###n#*##%#bg#vw#vn",2306) |> IO.inspect(label: "Expected #{inspect(?z)}, got")
