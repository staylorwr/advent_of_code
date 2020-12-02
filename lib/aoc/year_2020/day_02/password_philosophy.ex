defmodule Aoc.Year2020.Day02.PasswordPhilosophy do
  @moduledoc """
  ## --- Day 2: Password Philosophy ---

  Your flight departs in a few days from the coastal airport; the easiest way down
  to the coast from here is via toboggan.

  The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day.
  "Something's wrong with our computers; we can't log in!" You ask if you can take
  a look.

  Their password database seems to be a little corrupted: some of the passwords
  wouldn't have been allowed by the Official Toboggan Corporate Policy that was in
  effect when they were chosen.

  To try to debug the problem, they have created a list (your puzzle input) of
  *passwords* (according to the corrupted database) and *the corporate policy when
  that password was set*.

  For example, suppose you have the following list:

  ```
  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  ```

  Each line gives the password policy and then the password. The password policy
  indicates the lowest and highest number of times a given letter must appear for
  the password to be valid. For example, `1-3 a` means that the password must
  contain `a` at least `1` time and at most `3` times.

  In the above example, `*2*` passwords are valid. The middle password, `cdefg`,
  is not; it contains no instances of `b`, but needs at least `1`. The first and
  third passwords are valid: they contain one `a` or nine `c`, both within the
  limits of their respective policies.

  *How many passwords are valid* according to their pol


  ## --- Part Two ---

  While it appears you validated the passwords correctly, they don't seem to be
  what the Official Toboggan Corporate Authentication System is expecting.

  The shopkeeper suddenly realizes that he just accidentally explained the
  password policy rules from his old job at the sled rental place down the street!
  The Official Toboggan Corporate Policy actually works a little differently.

  Each policy actually describes two *positions in the password*, where `1` means
  the first character, `2` means the second character, and so on. (Be careful;
  Toboggan Corporate Policies have no concept of "index zero"!) *Exactly one of
  these positions* must contain the given letter. Other occurrences of the letter
  are irrelevant for the purposes of policy enforcement.

  Given the same example list from above:

  - `1-3 a: *a*b*c*de` is *valid*: position `1` contains `a` and position `3` does not.
  - `1-3 b: *c*d*e*fg` is *invalid*: neither position `1` nor position `3` contains `b`.
  - `2-9 c: c*c*cccccc*c*` is *invalid*: both position `2` and position `9` contain `c`.
  *How many passwords are valid* according to the new interpretation of the
  policies?

  """

  def part_1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&in_range_rule?/1)
    |> Enum.count(& &1)
  end

  @doc """

  """
  def part_2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&exact_character?/1)
    |> Enum.count(& &1)
  end

  def in_range_rule?(password_string) do
    [start_range, end_range, cx, password] = parse_line(password_string)

    password_count =
      password
      |> Enum.reduce([], fn x, acc ->
        x = String.to_atom(x)
        Keyword.update(acc, x, 1, fn value -> value + 1 end)
      end)
      |> Keyword.get(String.to_atom(cx), 0)

    Enum.member?(start_range..end_range, password_count)
  end

  def exact_character?(password_string) do
    [first_pos, second_pos, cx, password] = parse_line(password_string)

    first_match = if(Enum.at(password, first_pos - 1) == cx, do: true, else: false)
    second_match = if(Enum.at(password, second_pos - 1) == cx, do: true, else: false)

    is_exact?(first_match, second_match)
  end

  defp is_exact?(true, false), do: true
  defp is_exact?(false, true), do: true
  defp is_exact?(_, _), do: false

  defp parse_line(line) do
    [first_position, second_position, cx, password] =
      String.split(line, [" ", ":", "-"], trim: true)

    first_pos = String.to_integer(first_position)
    second_pos = String.to_integer(second_position)

    [first_pos, second_pos, cx, String.codepoints(password)]
  end
end
