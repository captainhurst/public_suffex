defmodule PublicSuffex do
  use PublicSuffex.Suffixer

  def parse(url) do
    url
    |> String.reverse
    |> do_parse
  end

  defp do_parse(reversed) do
    result = @tlds
      |> Enum.filter(fn tld -> String.starts_with?(reversed, tld) end)
      |> List.first

    case result do
      x when x |> is_binary -> String.reverse(x)
      _ -> nil
    end 
  end
end

# open_file! |> break_into_lines |> strip_lines |> strip_comments |> sort_lines