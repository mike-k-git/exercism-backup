defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string), do: do_encode(string, "")

  defp do_encode("", res), do: res

  defp do_encode(string, res) do
    [group, char] = Regex.run(~r/(.)\1*/, string)

    if String.length(group) == 1 do
      do_encode(String.replace_prefix(string, char, ""), res <> char)
    else
      do_encode(
        String.replace_prefix(string, group, ""),
        res <> to_string(String.length(group)) <> char
      )
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string), do: do_decode(string, "")

  defp do_decode("", res), do: res

  defp do_decode(string, res) do
    [group, count, char] = Regex.run(~r/(?:(\d*)([a-zA-Z ]))/, string)

    if count == "" do
      do_decode(String.replace_prefix(string, group, ""), res <> char)
    else
      {n, ""} = Integer.parse(count)
      do_decode(String.replace_prefix(string, group, ""), res <> String.duplicate(char, n))
    end
  end
end
