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

  defmodule StillLife do
    alias Utils

    def loaf_at_center(state, dimension) do
      center = Utils.calc_center_center(dimension)
      left_most = center |> left(dimension, 1)
      state |> loaf_at(dimension, left_most)
    end

    def loaf_at(state, d, left_most_index) do
      indexes = [
        left_most_index,
        # top bar
        left_most_index |> top_right(d),
        left_most_index |> top_right(d) |> right(d),
        # right vertical bar
        left_most_index |> right(d, 3),
        left_most_index |> right(d, 3) |> bottom(d),
        # bottom slope
        left_most_index |> bottom_right(d),
        left_most_index |> bottom_right(d) |> bottom_right(d)
      ]

      state |> Utils.set_indexes_state_value(indexes, :live)
    end

    def tub_at_center(state, dimension) do
      center = Utils.calc_center_center(dimension)
      state |> tub_at(dimension, center)
    end

    def tub_at(state, d, center_index) do
      indexes = [
        center_index |> top(d),
        center_index |> bottom(d),
        center_index |> left(d),
        center_index |> right(d)
      ]

      state |> Utils.set_indexes_state_value(indexes, :live)
    end

    def boat_at_center(state, dimension) do
      center = Utils.calc_center_center(dimension)
      state |> boat_at(dimension, center)
    end

    def boat_at(state, d, center_index) do
      indexes =
        [
          tub_at(state, d, center_index),
          center_index |> top_left(d)
        ]
        |> List.flatten()

      state |> Utils.set_indexes_state_value(indexes, :live)
    end
  end
end
