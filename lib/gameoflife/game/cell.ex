defmodule Gameoflife.Game.Cell do
  alias Gameoflife.Game.Cell

  use Memoize

  defstruct state: :dead

  def new(state), do: %Cell{state: state}

  def new(), do: %Cell{}

  def set_state(cell, state), do: %Cell{cell | state: state}

  def next(%Cell{state: state} = cell, neighbours) do
    %Cell{cell | state: next_state(state, count_state(neighbours, :live))}
  end

  # 1. Any live cell with two or three live neighbours survives.
  defmemo(
    next_state(:live, live_neighbour_count)
    when 2 <= live_neighbour_count and live_neighbour_count <= 3,
    do: :live
  )

  # 2. Any dead cell with three live neighbours becomes a live cell.
  defmemo(next_state(:dead, live_neighbour_count) when live_neighbour_count == 3, do: :live)

  # 3. All other live cells die in the next generation. Similarly, all other dead cells stay dead.
  defmemo(next_state(_, _), do: :dead)

  defp count_state(cells, state), do: Enum.count(cells, fn c -> c.state == state end)
end
