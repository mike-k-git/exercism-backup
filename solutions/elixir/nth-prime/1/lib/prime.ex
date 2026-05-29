defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(RuntimeError)
  def nth(1), do: 2
  def nth(2), do: 3

  def nth(count) do
    Stream.iterate(4, fn x -> x + 1 end)
    |> Enum.reduce_while(3, fn x, acc ->
      case is_prime?(x) do
        true ->
          if acc == count do
            {:halt, x}
          else
            {:cont, acc + 1}
          end

        false ->
          {:cont, acc}
      end
    end)
  end

  defp is_prime?(c) when rem(c, 2) == 0, do: false

  defp is_prime?(c) do
    !Enum.any?(2..floor(:math.sqrt(c)), fn n -> rem(c, n) == 0 end)
  end
end
