defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(<<c, _rest::binary>> = word) when c in ~c"aeiou", do: word <> "ay"
  defp translate_word(<<"xr", _rest::binary>> = word), do: word <> "ay"
  defp translate_word(<<"yt", _rest::binary>> = word), do: word <> "ay"
  defp translate_word(word), do: do_split(word, "")

  defp do_split(<<"qu", rest::binary>>, suffix), do: rest <> suffix <> "quay"

  defp do_split(<<c, "y", rest::binary>>, suffix) when c not in ~c"aeiou",
    do: "y" <> rest <> suffix <> <<c>> <> "ay"

  defp do_split(<<c, rest::binary>>, suffix) when c in ~c"aeiou",
    do: <<c>> <> rest <> suffix <> "ay"

  defp do_split(<<c, rest::binary>>, suffix), do: do_split(rest, suffix <> <<c>>)
end
