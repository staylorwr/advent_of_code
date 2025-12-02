# Advent of Code Solutions

My personal solutions to [Advent of Code](https://adventofcode.com) challenges, implemented in Elixir.

This repo is built using my open-source [elixir_aoc skeleton](https://github.com/staylorwr/elixir_aoc), which provides a generator for scaffolding each day's solution.

## Generator Usage

The skeleton includes a Mix task to generate scaffolding for each day:

```elixir
mix aoc.gen DAY [--year YEAR]
```

Running `mix aoc.gen 1` will:

* Generate a new module based on the problem title at `lib/aoc/year_YYYY/day_DD/problem_title.ex`
* Parse the HTML description of the problem into `@moduledoc` markdown
* Download your unique problem input into `priv` (requires session token)
* Generate a test file with the problem examples and input loading

## Setup

To use the generator, set your Advent of Code session token as an environment variable:

```bash
export AOC_SESSION=your_session_token
```

You can find your session token in your browser's cookies after logging into [Advent of Code](https://adventofcode.com).

## Solutions by Year

- 2017: Day 01
- 2018: Days 01-11
- 2019: Days 01-02
- 2020: Days 01-10
- 2021: Days 01-09, 13, 14, 17
- 2022: Days 01-16
- 2023: Days 01-04
- 2024: Days 01-06
- 2025: ?

