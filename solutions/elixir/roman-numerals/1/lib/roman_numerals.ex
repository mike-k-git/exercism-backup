defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number), do: do_numeral(number, "")

  defp do_numeral(0, res), do: res

  defp do_numeral(n, res) when n >= 1000 do
    process(n, res, 1000, "M", "M", "M")
  end

  defp do_numeral(n, res) when n >= 100 do
    process(n, res, 100, "C", "D", "M")
  end

  defp do_numeral(n, res) when n >= 10 do
    process(n, res, 10, "X", "L", "C")
  end

  defp do_numeral(n, res) do
    process(n, res, 1, "I", "V", "X")
  end

  defp process(n, res, divider, a, b, c) do
    case div(n, divider) do
      x when x < 4 ->
        res <> String.duplicate(a, x)

      x when x == 4 ->
        res <> a <> b

      x when x == 5 ->
        res <> b

      x when x < 9 ->
        res <> b <> String.duplicate(a, x - 5)

      x when x == 9 ->
        res <> a <> c
    end
    |> then(&do_numeral(rem(n, divider), &1))
  end
end
