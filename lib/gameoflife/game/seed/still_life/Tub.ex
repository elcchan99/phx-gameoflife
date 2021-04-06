defmodule Gameoflife.Game.Seed.StillLife.Tub do
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
      center_index |> top(d),
      center_index |> bottom(d),
      center_index |> left(d),
      center_index |> right(d)
    ]
end
