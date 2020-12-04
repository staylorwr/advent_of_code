defmodule Passport do
  @enforce_keys [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]

  defstruct [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid, :valid_keys?, :valid_values?]

  def new(fields) do
    struct(__MODULE__, fields)
    |> check_valid_keys()
    |> check_valid_values()
  end

  defp check_valid_keys(%Passport{} = passport) do
    %{passport | valid_keys?: valid?(passport)}
  end

  defp check_valid_values(%Passport{} = passport) do
    %{passport | valid_values?: passport.valid_keys? && valid_values?(passport)}
  end

  defp valid?(passport) do
    @enforce_keys
    |> List.delete(:cid)
    |> Enum.all?(&valid?(passport, &1))
  end

  defp valid?(passport, key), do: Map.get(passport, key) != nil

  defp valid_values?(passport) do
    @enforce_keys
    |> List.delete(:cid)
    |> Enum.all?(&valid_value?(passport, &1))
  end

  defp valid_value?(%Passport{byr: byr}, :byr) do
    String.length(byr) == 4 && String.to_integer(byr) in 1920..2002
  end

  defp valid_value?(%Passport{iyr: iyr}, :iyr) do
    String.length(iyr) == 4 && String.to_integer(iyr) in 2010..2020
  end

  defp valid_value?(%Passport{eyr: eyr}, :eyr) do
    String.length(eyr) == 4 && String.to_integer(eyr) in 2020..2030
  end

  defp valid_value?(%Passport{hgt: hgt}, :hgt) do
    case Regex.run(~r/^(\d+)(\w+)$/, hgt) do
      [_, val, "cm"] ->
        String.to_integer(val) in 150..193

      [_, val, "in"] ->
        String.to_integer(val) in 59..76

      _ ->
        false
    end
  end

  defp valid_value?(%Passport{hcl: hcl}, :hcl) do
    Regex.match?(~r/#[abcdef0-9]{6}/, hcl)
  end

  defp valid_value?(%Passport{ecl: ecl}, :ecl) do
    ecl in ~w(amb blu brn gry grn hzl oth)
  end

  defp valid_value?(%Passport{pid: pid}, :pid) do
    Regex.match?(~r/^[0-9]{9}$/, pid)
  end
end

defmodule Aoc.Year2020.Day04.PassportProcessing do
  @moduledoc """
  ## --- Day 4: Passport Processing ---

  You arrive at the airport only to realize that you grabbed your North Pole
  Credentials instead of your passport. While these documents are extremely
  similar, North Pole Credentials aren't issued by a country and therefore aren't
  actually valid documentation for travel in most of the world.

  It seems like you're not the only one having problems, though; a very long line
  has formed for the automatic passport scanners, and the delay could upset your
  travel itinerary.

  Due to some questionable network security, you realize you might be able to
  solve both of these problems at the same time.

  The automatic passport scanners are slow because they're having trouble
  *detecting which passports have all required fields*. The expected fields are as
  follows:

  - `byr` (Birth Year)
  - `iyr` (Issue Year)
  - `eyr` (Expiration Year)
  - `hgt` (Height)
  - `hcl` (Hair Color)
  - `ecl` (Eye Color)
  - `pid` (Passport ID)
  - `cid` (Country ID)

  Passport data is validated in batch files (your puzzle input). Each passport is
  represented as a sequence of `key:value` pairs separated by spaces or newlines.
  Passports are separated by blank lines.

  Here is an example batch file containing four passports:

  ```
  ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  byr:1937 iyr:2017 cid:147 hgt:183cm

  iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
  hcl:#cfa07d byr:1929

  hcl:#ae17e1 iyr:2013
  eyr:2024
  ecl:brn pid:760753108 byr:1931
  hgt:179cm

  hcl:#cfa07d eyr:2025 pid:166559648
  iyr:2011 ecl:brn hgt:59in
  ```
  The first passport is *valid* - all eight fields are present. The second
  passport is *invalid* - it is missing `hgt` (the Height field).

  The third passport is interesting; the *only missing field* is `cid`, so it
  looks like data from North Pole Credentials, not a passport at all! Surely,
  nobody would mind if you made the system temporarily ignore missing `cid`
  fields. Treat this "passport" as *valid*.

  The fourth passport is missing two fields, `cid` and `byr`. Missing `cid` is
  fine, but missing any other field is not, so this passport is *invalid*.

  According to the above rules, your improved system would report `*2*` valid
  passports.

  Count the number of *valid* passports - those that have all required fields.
  Treat `cid` as optional. *In your batch file, how many passports are valid?*
  """

  @doc """

  """
  def part_1(input) do
    input
    |> parse()
    |> Enum.filter(& &1.valid_keys?)
    |> Enum.count()
  end

  @doc """

  """
  def part_2(input) do
    input
    |> parse()
    |> Enum.filter(& &1.valid_values?)
    |> Enum.count()
  end

  def parse(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn record ->
      record
      |> String.split([" ", "\n"], trim: true)
      |> Enum.into(%{}, fn x ->
        [y, z] = String.split(x, ":", trim: true)
        {String.to_atom(y), z}
      end)
      |> Passport.new()
    end)
  end
end
