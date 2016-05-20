defmodule PublicSuffex.Suffixer do
  
  @path  "./data/public_suffix_list.dat.txt"
  
  defmacro __using__(_) do
    quote do
      
      Module.put_attribute __MODULE__, :tlds, PublicSuffex.Suffixer.create_suffix

      def tlds do
        @tlds
      end

    end
  end

  def split_domain(domain) do
    String.split(domain, ".")
  end 

  def open_file! do
    case File.open(@path, [:read, :write], fn(file) -> IO.read(file, :all) end) do
      {:ok, bytes} -> bytes
      _ -> raise "Failed to open file #{inspect @path}"
    end
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

  def as_mapset(tlds) do
    tlds
    |> Enum.into(MapSet.new)
  end

  def create_suffix do
    open_file! 
    |> break_into_lines 
    |> strip_lines 
    |> strip_comments
    |> as_mapset
  end



end
