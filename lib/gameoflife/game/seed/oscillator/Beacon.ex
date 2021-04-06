defmodule Gameoflife.Game.Seed.Oscillator.Beacon do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder
  alias Gameoflife.Game.Seed.StillLife.Block

  @behaviour Seeder

  @impl Seeder
  def default_ref_index(dimension) do
    calc_center_center(dimension)
    |> top_left(dimension)
  end

  @impl Seeder
  def indexes_at(d, top_left_index) do
    second_square_top_left = top_left_index |> bottom_right(d) |> bottom_right(d)

    [Block.indexes_at(d, top_left_index), Block.indexes_at(d, second_square_top_left)]
    |> List.flatten()
  end
end
