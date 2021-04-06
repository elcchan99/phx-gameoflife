defmodule Gameoflife.Game.Seed do
  alias Gameoflife.Game.BoardUtils

  def empty() do
    %{}
  end

  defmodule Utils do
    def calc_middle(n) when rem(n, 2) == 0, do: div(n, 2) - 1
    def calc_middle(n), do: div(n, 2)
  end

  def horizontal_line_at_middle(state, width, height) do
    mid_row = Utils.calc_middle(height)

    state
    |> horizontal_line_at(width, mid_row)
  end

  def horizontal_line_at(state, width, row_index) do
    0..(width - 1)
    |> Enum.map(&(row_index * width + &1))
    |> Enum.reduce(state, fn i, acc -> Map.put(acc, i, :live) end)
  end

  defmodule StillLife do
    alias Utils

    def block_at_middle(state, width, height) do
      index =
        (Utils.calc_middle(height) * width + Utils.calc_middle(height))
        |> IO.inspect(label: "block_at_index")

      state |> block_at(width, height, index)
    end

    def block_at(state, w, h, top_left_index) do
      [
        top_left_index,
        BoardUtils.neighbour_right(w, h, top_left_index),
        BoardUtils.neighbour_bottom(w, h, top_left_index),
        BoardUtils.neighbour_right(w, h, BoardUtils.neighbour_bottom(w, h, top_left_index))
      ]
      |> Enum.reduce(state, fn i, acc -> Map.put(acc, i, :live) end)
    end
  end
end
