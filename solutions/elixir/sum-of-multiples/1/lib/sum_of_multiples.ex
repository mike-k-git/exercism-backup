defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.reject(&(&1 == 0))
    |> Enum.map(fn factor ->
      for n <- factor..(limit - 1)//1, rem(n, factor) == 0, do: n
    end)
    |> Enum.flat_map(&List.flatten/1)
    |> Enum.uniq()
    |> Enum.sum()
  end
end
