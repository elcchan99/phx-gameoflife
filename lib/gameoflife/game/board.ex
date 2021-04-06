defmodule Gameoflife.Game.Board do
  alias Gameoflife.Game.BoardUtils
  alias Gameoflife.Game.Board
  alias Gameoflife.Game.Seed

  defstruct width: 10, height: 20, state: nil, generation: 0

  def new(width, height), do: new(width, height, fn x, _, _ -> x end)

  def new(width, height, seed) do
    %Board{
      width: width,
      height: height,
      state: Seed.empty() |> seed.(height, width),
      generation: 0
    }
  end

  def next(%Board{state: state, generation: generation} = board) do
    %Board{board | state: next_state(board, state), generation: generation + 1}
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
