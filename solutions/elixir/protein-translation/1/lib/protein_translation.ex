defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(""), do: {:ok, []}
  def of_rna(rna), do: do_of_rna(rna, [])

  defp do_of_rna(<<codon::binary-size(3), rest::binary>>, proteins) do
    case of_codon(codon) do
      {:ok, "STOP"} ->
        {:ok, Enum.reverse(proteins)}

      {:ok, protein} ->
        do_of_rna(rest, [protein | proteins])

      _ ->
        {:error, "invalid RNA"}
    end
  end

  defp do_of_rna(<<>>, proteins), do: {:ok, Enum.reverse(proteins)}

  defp do_of_rna(_, _), do: {:error, "invalid RNA"}

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case codon do
      c when c in ["UGU", "UGC"] -> {:ok, "Cysteine"}
      c when c in ["UUA", "UUG"] -> {:ok, "Leucine"}
      "AUG" -> {:ok, "Methionine"}
      c when c in ["UUU", "UUC"] -> {:ok, "Phenylalanine"}
      c when c in ["UCU", "UCC", "UCA", "UCG"] -> {:ok, "Serine"}
      "UGG" -> {:ok, "Tryptophan"}
      c when c in ["UAU", "UAC"] -> {:ok, "Tyrosine"}
      c when c in ["UAA", "UAG", "UGA"] -> {:ok, "STOP"}
      _ -> {:error, "invalid codon"}
    end
  end
end
