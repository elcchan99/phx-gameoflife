defmodule Gameoflife.Game.Seed.Oscillator.Block do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder

  @behaviour Seeder

  @impl Seeder
  def default_ref_index(dimension) do
    calc_center_center(dimension)
  end

  @impl Seeder
  def indexes_at(d, top_left_index),
    do: [
      top_left_index,
      right(top_left_index, d),
      bottom(top_left_index, d),
      top_left_index |> bottom_right(d)
    ]
end
