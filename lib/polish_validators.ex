defmodule PolishValidators do
  @nip_wages [6, 5, 7, 2, 3, 4, 5, 6, 7]
  @pesel_wages [9, 7, 3, 1, 9, 7, 3, 1, 9, 7]
  @regon_wages [8, 9, 2, 3, 4, 5, 6, 7]
  @regon14_wages [2, 4, 8, 5, 0, 9, 7, 3, 6, 1, 2, 4, 8]
  @nip_length 10
  @pesel_length 11
  @regon_length 9
  @regon14_length 14
  @mod_pesel 10
  @mod_nip 11
  @mod_regon 11
  @mod_regon14 11

  defp sum([current | rest], [weight | tail]) do
    current * weight + sum(rest, tail)
  end

  defp sum(_, []), do: 0

  defp to_integers(string) do
    string |> String.split("")
           |> Enum.drop(-1)
           |> Enum.map(fn(num) -> num |> String.to_integer end)
  end

  defp format_number(string) do
    String.replace(string, "-", "") |> String.trim
  end

  defp validate(no, wages, no_check, modulo) do
    no |> sum(wages)
       |> rem(modulo) == Enum.at no, no_check
  end

  defp regon_validate(no, len) do
    if (len == @regon_length) do
      validate no, @regon_wages, @regon_length - 1, @mod_regon
    else
      validate no, @regon14_wages, @regon14_length - 1, @mod_regon14
    end
  end

  def is_valid_pesel(pesel) do
    formated = pesel |> format_number
    if String.length(formated) != @pesel_length do
      false
    else
      formated |> to_integers
               |> validate(@pesel_wages, @pesel_length - 1, @mod_pesel)
    end
  end

  def is_valid_nip(nip) do
    formated = nip |> format_number
    if String.length(formated) != @nip_length do
      false
    else
      formated |> to_integers
               |> validate(@nip_wages, @nip_length - 1, @mod_nip)
    end
  end

  def is_valid_regon(regon) do
    formated = regon |> format_number
    len = String.length(formated)
    if (len != @regon_length and len != @regon14_length) do
      false
    else
      formated |> to_integers |> regon_validate(len)
    end
  end
end
