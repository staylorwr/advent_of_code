defmodule Aoc.Year2018.Day07.PartTwo do
  @enforce_keys [:steps, :dependencies, :workers, :delay]
  defstruct second: -1,
            workers: [],
            steps: [],
            completed: [],
            dependencies: [],
            delay: 0,
            print: false

  def part_2(input, options) do
    input
    |> new(options)
    |> print_header
    |> iterate
    |> Map.get(:second)
  end

  def parse(input) do
    input
    |> String.trim_trailing("\n")
    |> String.split("\n")
    |> Enum.map(&parse_step/1)
  end

  def new(input, options) do
    requirements = parse(input)
    steps = steps_list(requirements)
    dependencies = build_dependencies(requirements)
    print = Keyword.get(options, :print, false)
    delay = Keyword.get(options, :delay, 60)
    workers = Keyword.get(options, :workers, 5)
    workers = Enum.map(1..workers, fn _ -> {nil, 0} end)

    %__MODULE__{
      workers: workers,
      steps: steps,
      dependencies: dependencies,
      delay: delay,
      print: print
    }
  end

  def build_dependencies(requirements) do
    deps = requirements |> steps_list |> Enum.map(&{&1, []}) |> Enum.into(%{})

    Enum.reduce(requirements, deps, fn [a, b], acc ->
      Map.update(acc, b, [a], &[a | &1])
    end)
  end

  def iterate(state) do
    next_state = tick(state)
    workers_done = Enum.all?(next_state.workers, fn {_, time} -> time == 0 end)

    if next_state.steps == [] && workers_done do
      next_state
    else
      iterate(next_state)
    end
  end

  def tick(state) do
    state
    |> increment_second
    |> decrement_time_ongoing_tasks
    |> gather_completed_tasks
    |> assign_new_tasks
    |> print
  end

  defp increment_second(state), do: %{state | second: state.second + 1}

  defp decrement_time_ongoing_tasks(state) do
    workers =
      Enum.map(state.workers, fn
        {nil, 0} -> {nil, 0}
        {task, time_left} -> {task, time_left - 1}
      end)

    %{state | workers: workers}
  end

  def gather_completed_tasks(state) do
    {workers, completed} =
      Enum.map_reduce(
        state.workers,
        state.completed,
        &do_gather_completed_tasks/2
      )

    %{state | workers: workers, completed: completed}
  end

  def assign_new_tasks(state) do
    # Determine ready tasks
    workers_free = Enum.count(state.workers, &(elem(&1, 1) == 0))
    ready = ready_list(state) |> Enum.take(workers_free)

    {workers, left} =
      Enum.map_reduce(
        state.workers,
        ready,
        &assign_new_tasks(&1, &2, state.delay)
      )

    unless left == [], do: raise(ArgumentError, message: "left #{inspect(left)}")

    steps = state.steps -- ready

    %{state | workers: workers, steps: steps}
  end

  # Worker has no current task, nothing to do
  defp do_gather_completed_tasks({nil, 0}, done) do
    {{nil, 0}, done}
  end

  # Worker has time left on a task, nothing to do
  defp do_gather_completed_tasks({task, time_left}, done) when time_left > 0 do
    {{task, time_left}, done}
  end

  # Worker has completed task, move to done
  defp do_gather_completed_tasks({task, 0}, done) do
    {{nil, 0}, done ++ [task]}
  end

  # Worker has no current task, so give it a new one
  defp assign_new_tasks({nil, 0}, [new_task | ready], delay) do
    {{new_task, delay + time_needed(new_task)}, ready}
  end

  # Worker already has a task
  defp assign_new_tasks({task, time_left}, ready, _delay) do
    {{task, time_left}, ready}
  end

  def time_needed(task) do
    hd(String.to_charlist(task)) - ?@
  end

  defp steps_list(requirements) do
    requirements
    |> Enum.flat_map(& &1)
    |> Enum.sort()
    |> Enum.uniq()
  end

  def ready_list(state) do
    state.steps
    |> Enum.filter(&do_ready?(&1, state))
    |> Enum.sort()
  end

  defp do_ready?(step, state) do
    state.dependencies
    |> Map.get(step)
    |> Enum.all?(&(&1 in state.completed))
  end

  def parse_step(line) do
    case Regex.scan(~r/^.+ (\w) .+ (\w) .+$/, line) do
      [[_, a, b]] -> [a, b]
    end
  end

  def print_header(%{print: false} = state), do: state

  def print_header(state) do
    workers =
      state.workers
      |> Enum.with_index()
      |> Enum.map_join("", fn {_, index} -> "   Worker #{index + 1}" end)

    IO.puts("\nSecond#{workers}   Done")

    state
  end

  def print(%{print: false} = state), do: state

  def print(state) do
    worker_columns =
      Enum.map_join(state.workers, " ", fn
        {nil, _} ->
          "    .     "

        {task, _} ->
          "    #{task}     "
      end)

    second =
      case state.second do
        s when s < 10 -> "   #{s}   "
        s when s < 100 -> "  #{s}   "
        s when s < 1000 -> " #{s}   "
        s -> "#{s}   "
      end

    IO.puts(
      String.trim_trailing("#{second} #{worker_columns}  #{Enum.join(state.completed, "")}")
    )

    state
  end
end
