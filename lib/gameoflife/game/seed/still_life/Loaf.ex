defmodule Gameoflife.Game.Seed.StillLife.Loaf do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder

  @behaviour Seeder

  @impl Seeder
  def display_name, do: "Loaf"

  @impl Seeder
  def default_ref_index(dimension) do
    calc_center_center(dimension) |> left(dimension, 1)
  end

  @impl Seeder
  def indexes_at(d, left_most_index) do
    [
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
  end
end
