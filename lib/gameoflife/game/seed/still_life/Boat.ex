defmodule Gameoflife.Game.Seed.StillLife.Boat do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder
  # alias Gameoflife.Game.Seed.Utils
  alias Gameoflife.Game.Seed.StillLife.Tub

  @behaviour Seeder

  @impl Seeder
  def default_ref_index(dimension) do
    Tub.default_ref_index(dimension)
  end

  @impl Seeder
  def indexes_at(d, center_index),
    do: [
      center_index |> top_left(d)
      | Tub.indexes_at(d, center_index)
    ]
end
