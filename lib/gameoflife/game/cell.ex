defmodule Gameoflife.Game.Cell do
  # alias Gameoflife.Game.Cell

  use Memoize

  def new(state), do: state

  def new(), do: :dead

  def set_state(_, state), do: state

  def get_state(cell), do: cell

  def next(state, neighbours) do
    next_state(state, count_state(neighbours, :live))
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

  defp count_state(cells, state), do: Enum.count(cells, fn c -> get_state(c) == state end)
end
