defmodule Gameoflife.Game.Seed.StillLife.BeeHive do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder
  alias Gameoflife.Game.Seed.Utils

  @behaviour Seeder

  @impl Seeder
  def default_ref_index(dimension) do
    Utils.calc_center_center(dimension) |> left(dimension, 1)
  end

  @impl Seeder
  def indexes_at(d, left_most_index) do
    top_bar = [
      left_most_index |> top_right(d),
      left_most_index |> top_right(d) |> right(d)
    ]

    bottom_bar = top_bar |> Enum.map(fn i -> i |> bottom(d) |> bottom(d) end)

    [
      left_most_index,
      top_bar,
      bottom_bar,
      left_most_index |> right(d, 3)
    ]
    |> List.flatten()
  end
end
