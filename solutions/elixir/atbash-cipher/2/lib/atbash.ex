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

  defp convert(str, banned) do
    str
    |> String.downcase()
    |> to_charlist()
    |> Enum.reject(&(&1 in banned))
    |> Enum.map(fn char ->
      case char do
        c when c in ?a..?z -> ?z - c + ?a
        c -> c
      end
    end)
  end
end
