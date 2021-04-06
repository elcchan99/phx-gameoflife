defmodule Gameoflife.Game.Seed.Oscillator.Toad do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder

  @behaviour Seeder

  @impl Seeder
  def default_ref_index(dimension) do
    calc_center_center(dimension)
    |> bottom_left(dimension)
  end

  @impl Seeder
  def indexes_at(d, left_most_index) do
    top_left_index = top_right(left_most_index, d)

    [
      left_most_index,
      left_most_index |> right(d),
      left_most_index |> right(d, 2),
      top_left_index,
      top_left_index |> right(d),
      top_left_index |> right(d, 2)
    ]
  end
end
