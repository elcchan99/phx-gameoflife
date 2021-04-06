defmodule Gameoflife.Game.Seed.Spaceship.Glider do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder

  @behaviour Seeder

  @impl Seeder
  def display_name, do: "Glider"

  @impl Seeder
  def default_ref_index(_), do: 0

  @impl Seeder
  def indexes_at(d, top_left_index) do
    [
      top_left_index,
      top_left_index |> bottom(d) |> bottom(d),
      top_left_index |> bottom_right(d),
      top_left_index |> bottom_right(d) |> bottom(d),
      top_left_index |> bottom_right(d) |> right(d)
    ]
  end
end
