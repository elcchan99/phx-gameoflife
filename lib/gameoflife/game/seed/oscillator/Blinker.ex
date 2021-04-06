defmodule Gameoflife.Game.Seed.Oscillator.Blinker do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder

  @behaviour Seeder

  @impl Seeder

  def default_ref_index(dimension) do
    calc_center_center(dimension)
  end

  @impl Seeder
  def indexes_at(d, center_index),
    do: [
      top(center_index, d),
      center_index,
      bottom(center_index, d)
    ]
end
