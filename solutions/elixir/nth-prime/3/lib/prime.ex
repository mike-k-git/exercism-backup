defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(ArgumentError, "there is no zeroth prime")

  def nth(count) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&prime?/1)
    |> Enum.at(count - 1)
  end

  defp prime?(2), do: true
  defp prime?(n) when rem(n, 2) == 0, do: false

  defp prime?(c) do
    3..floor(:math.sqrt(c))//2
    |> Enum.any?(fn n -> rem(c, n) == 0 end)
    |> Kernel.not()
  end
end
