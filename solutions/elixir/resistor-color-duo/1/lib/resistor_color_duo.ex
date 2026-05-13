defmodule ResistorColorDuo do
  @resistance %{
    {:black, 0},
    {:brown, 1},
    {:red, 2},
    {:orange, 3},
    {:yellow, 4},
    {:green, 5},
    {:blue, 6},
    {:violet, 7},
    {:grey, 8},
    {:white, 9}
  }

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    with [first, second | _] <- colors do
      @resistance[first] * 10 + @resistance[second]
    end
  end
end
