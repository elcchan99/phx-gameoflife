defmodule Gameoflife.Game.Seed do
  def empty() do
    %{}
  end

  def horizontal_line_at_middle(state, width, height) do
    mid_row = div(height, 2)

    state
    |> horizontal_line_at(width, mid_row)
  end

  def horizontal_line_at(state, width, row_index) do
    0..(width - 1)
    |> Enum.map(&(row_index * width + &1))
    |> Enum.reduce(state, fn i, acc -> Map.put(acc, i, :live) end)
  end

end
