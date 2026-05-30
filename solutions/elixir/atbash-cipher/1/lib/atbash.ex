defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> convert(~c" .,!?")
    |> Enum.chunk_every(5, 5, [])
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> convert(~c" ")
    |> to_string()
  end

  defp convert(lower_str, banned) do
    lower_str
    |> to_charlist()
    |> Enum.reject(&(&1 in banned))
    |> Enum.map(fn char ->
      case char do
        c when c in ?a..?m -> ?z - (c - ?a)
        c when c in ?n..?z -> ?z - c + ?a
        _ -> char
      end
    end)
  end
end
