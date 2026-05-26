defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  # def encode(string), do: do_encode(string, "")

  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map(fn chunk ->
      case length(chunk) do
        1 ->
          chunk

        n ->
          to_string(n) <> List.first(chunk)
      end
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(\d*)([a-zA-Z ])/, string, capture: :all_but_first)
    |> Enum.map(fn [count, char] ->
      case Integer.parse(count) do
        {n, ""} -> String.duplicate(char, n)
        :error -> char
      end
    end)
    |> Enum.join()
  end
end
