defmodule PublicSuffex do
  use PublicSuffex.Suffixer

  def parse(url) when url |> is_binary do
    url
    |> into_parts
    |> recombine
    |> list_to_mapset
    |> get_intersection(@tlds)
    |> find_longest
  end

  defp get_intersection(mapset1, mapset2) do
    MapSet.intersection(mapset1, mapset2)
  end

  defp into_parts(url) do
    url
    |> String.split(".")
  end

  defp recombine(list) do
    len = list |> length
    0..len - 1
    |> Enum.map(fn i -> Enum.slice(list, i, len) end)
    |> Enum.map(fn group -> Enum.join(group, ".") end)
  end

  defp list_to_mapset(list) do
    list |> Enum.into(MapSet.new)
  end

  def mapset_to_list(mapset) do
    mapset |> Enum.into([])
  end

  defp find_longest(words) do
    case words do
      []                        -> nil
      %MapSet{} = mapset        -> mapset |> mapset_to_list |> find_longest
      list when list |> is_list -> list |> do_find_longest
    end
  end

  def do_find_longest(list) do
    list
    |> Enum.sort_by(&String.length/1)
    |> Enum.reverse
    |> List.first
  end

end
