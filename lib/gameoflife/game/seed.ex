defmodule Gameoflife.Game.Seed do
  import Gameoflife.Game.BoardUtils

  def empty(_, _), do: empty()
  def empty(), do: %{}

  defmodule Utils do
    def calc_center(n) when rem(n, 2) == 0, do: div(n, 2) - 1
    def calc_center(n), do: div(n, 2)
    def calc_center_center({w, h}), do: Utils.calc_center(h) * w + Utils.calc_center(w)

    def set_indexes_state_value(state, indexes, value) do
      indexes |> Enum.reduce(state, fn i, acc -> Map.put(acc, i, value) end)
    end
  end

  def horizontal_line_at_center(state, {_, h} = dimension) do
    mid_row = Utils.calc_center(h)

    state
    |> horizontal_line_at(dimension, mid_row)
  end

  def horizontal_line_at(state, {w, _}, row_index) do
    indexes = 0..(w - 1) |> Enum.map(&(row_index * w + &1))
    state |> Utils.set_indexes_state_value(indexes, :live)
  end

  defmodule StillLife do
    alias Utils

    def block_at_center(state, dimension) do
      state
      |> block_at(dimension, Utils.calc_center_center(dimension))
    end

    def block_at(state, d, top_left_index) do
      indexes = [
        top_left_index,
        right(top_left_index, d),
        bottom(top_left_index, d),
        top_left_index |> bottom_right(d)
      ]

      state |> Utils.set_indexes_state_value(indexes, :live)
    end

    def bee_hive_at_center(state, dimension) do
      center = Utils.calc_center_center(dimension)
      left_most = center |> left(dimension, 1)
      state |> bee_hive_at(dimension, left_most)
    end

    def bee_hive_at(state, d, left_most_index) do
      top_bar = [
        left_most_index |> top_right(d),
        left_most_index |> top_right(d) |> right(d)
      ]

      bottom_bar = top_bar |> Enum.map(fn i -> i |> bottom(d) |> bottom(d) end)

      indexes =
        [
          left_most_index,
          top_bar,
          bottom_bar,
          left_most_index |> right(d, 3)
        ]
        |> List.flatten()

      state |> Utils.set_indexes_state_value(indexes, :live)
    end
  end
end
