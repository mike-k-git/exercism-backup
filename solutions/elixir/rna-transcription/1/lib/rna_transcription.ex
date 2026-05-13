defmodule RnaTranscription do
  @complements %{
    {71, 67},
    {67, 71},
    {84, 65},
    {65, 85}
  }
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: do_to_rna(dna, ~c"")

  defp do_to_rna([], rna), do: Enum.reverse(rna)
  defp do_to_rna([nucleotide | tail], rna), do: do_to_rna(tail, [@complements[nucleotide] | rna])
end
