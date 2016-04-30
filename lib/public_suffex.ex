defmodule PublicSuffex do
  @path  "./data/public_suffix_list.dat.txt"

  defmacro suffix(line) do
    matcher = String.to_atom("match_#{line}")
    quote do
      def unquote(matcher)(data) do
        Enum.filter(data, fn
          (unquote(line)) -> true
          (_) -> false
        end)
        # unquote(atom)
      end
    end
  end

  def split_domain(domain) do
    String.split(domain, ".")
  end

  def open_file! do
    File.read!(@path)
  end

  def break_into_lines(file) do

    String.split(file, "\n")
  end

  def strip_lines(lines) do
    Enum.map(lines, fn (line) -> line |> String.strip end)
  end

  def strip_comments(lines) do
    Enum.filter(lines, fn
      ("//" <> _) -> false
      ("//")      -> false
      ("")        -> false
      (_)         -> true
    end)
  end

end
