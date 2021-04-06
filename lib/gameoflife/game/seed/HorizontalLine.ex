defmodule Gameoflife.Game.Seed.HorizontalLine do
  import Gameoflife.Game.BoardUtils

  alias Gameoflife.Game.Seeder
  alias Gameoflife.Game.Seed.Utils

  @behaviour Seeder

  @impl Seeder
  def default_ref_index({_, h}) do
    Utils.calc_center(h)
  end

  @impl Seeder
  def indexes_at({w, _}, row_index),
    do: 0..(w - 1) |> Enum.map(&(row_index * w + &1))
end
