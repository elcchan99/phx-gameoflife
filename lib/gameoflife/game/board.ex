defmodule Gameoflife.Game.Board do
  alias Gameoflife.Game.BoardUtils
  alias Gameoflife.Game.Board
  alias Gameoflife.Game.Seed

  defstruct width: 10, height: 20, state: nil

  def new(width, height) do
    mid_row = div(height, 2)

    %Board{
      width: width,
      height: height,
      # Seed.horizontal_line_at(width, mid_row)
      # Seed.StillLife.block_at(width, 2 + mid_row * width)
      state: Seed.empty() |> Seed.horizontal_line_at(width, mid_row)
    }
  end

  def next(%Board{state: state} = board) do
    %Board{board | state: next_state(board, state)}
  end

  def next_state(%Board{width: w, height: h}, state) do
    state
    # expand with neighbour indexes
    |> Enum.flat_map(fn {i, _} -> BoardUtils.neighbours_of(w, h, i) end)
    # count neighbour occurances
    |> Enum.frequencies()
    # filter live neighbours
    |> Enum.reduce(state, fn {i, count}, acc ->
      case Map.get(state, i, :dead) do
        :live ->
          cond do
            count >= 2 and count <= 3 -> Map.put(acc, i, :live)
            true -> Map.delete(acc, i)
          end

        :dead ->
          cond do
            count == 3 -> Map.put(acc, i, :live)
            true -> Map.delete(acc, i)
          end
      end
    end)
  end
end
