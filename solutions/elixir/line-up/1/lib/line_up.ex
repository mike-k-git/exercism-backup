defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    ordinal =
      cond do
        rem(number, 10) == 1 && rem(number, 100) != 11 -> "#{number}st"
        rem(number, 10) == 2 && rem(number, 100) != 12 -> "#{number}nd"
        rem(number, 10) == 3 && rem(number, 100) != 13 -> "#{number}rd"
        true -> "#{number}th"
      end

    "#{name}, you are the #{ordinal} customer we serve today. Thank you!"
  end
end
