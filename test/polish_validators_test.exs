defmodule PolishValidatorsTest do
  use ExUnit.Case
  doctest PolishValidators

  test "Is PESEL valid" do
    assert PolishValidators.is_valid_pesel("44051401458") == true
    assert PolishValidators.is_valid_pesel("440514014581") == false
    assert PolishValidators.is_valid_pesel("44051401459") == false
  end

  test "Is NIP valid" do
    assert PolishValidators.is_valid_nip("123-456-32-18") == true
    assert PolishValidators.is_valid_nip("1234563218") == true
    assert PolishValidators.is_valid_nip("1234563219") == false
    assert PolishValidators.is_valid_nip("12345632181") == false
  end

  test "Is REGON valid" do
    assert PolishValidators.is_valid_regon("123456785") == true
    assert PolishValidators.is_valid_regon("1234567851") == false
    assert PolishValidators.is_valid_regon("123456783") == false
    assert PolishValidators.is_valid_regon("12345678512347") == true
    assert PolishValidators.is_valid_regon("12345678512342") == false
    assert PolishValidators.is_valid_regon("123456785123411") == false

  end

end
