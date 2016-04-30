defmodule PublicSuffex do
  @path  "./data/public_suffix_list.dat.txt"

  defmacro suffix(lines) do
    
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
