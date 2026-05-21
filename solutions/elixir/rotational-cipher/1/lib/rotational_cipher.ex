defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(fn char ->
      case char do
        x when x >= ?a and x <= ?z -> rem(x - ?a + shift, 26) + ?a
        x when x >= ?A and x <= ?Z -> rem(x - ?A + shift, 26) + ?A
        x -> x
      end
    end)
    |> to_string()
  end
end
