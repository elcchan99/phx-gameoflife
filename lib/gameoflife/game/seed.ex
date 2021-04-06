defmodule Gameoflife.Game.Seed do
  import Gameoflife.Game.BoardUtils

  def empty(_, _, _), do: empty()
  def empty(), do: %{}

  defmodule Utils do
    def calc_center(n) when rem(n, 2) == 0, do: div(n, 2) - 1
    def calc_center(n), do: div(n, 2)

    def set_indexes_state_value(state, indexes, value) do
      indexes |> Enum.reduce(state, fn i, acc -> Map.put(acc, i, value) end)
    end
  end

  def horizontal_line_at_center(state, width, height) do
    mid_row = Utils.calc_center(height)

    state
    |> horizontal_line_at(width, mid_row)
  end

  def horizontal_line_at(state, width, row_index) do
    indexes = 0..(width - 1) |> Enum.map(&(row_index * width + &1))
    state |> Utils.set_indexes_state_value(indexes, :live)
  end

  defmodule StillLife do
    alias Utils

    def block_at_center(state, width, height) do
      state
      |> block_at(width, height, Utils.calc_center(height) * width + Utils.calc_center(width))
    end

    def block_at(state, w, h, top_left_index) do
      indexes = [
        top_left_index,
        neighbour_right(w, h, top_left_index),
        neighbour_bottom(w, h, top_left_index),
        neighbour_right(w, h, neighbour_bottom(w, h, top_left_index))
      ]

      state |> Utils.set_indexes_state_value(indexes, :live)
    end
  end
end
