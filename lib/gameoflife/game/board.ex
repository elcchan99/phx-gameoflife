defmodule Gameoflife.Game.Board do
  alias Gameoflife.Game.BoardUtils
  alias Gameoflife.Game.Board

  defstruct width: 10, height: 20, state: nil, generation: 0

  def new(width, height), do: new(width, height, fn x, _ -> x end)

  def new(width, height, seed) do
    %Board{
      width: width,
      height: height,
      state: %{} |> seed.({width, height}),
      generation: 0
    }
  end

  def next(%Board{state: state, generation: generation} = board) do
    %Board{board | state: next_state(board, state), generation: generation + 1}
  end

  def next_state(%Board{width: w, height: h}, state) do
    state
    # expand with neighbour indexes
    |> Stream.flat_map(fn {i, _} -> BoardUtils.neighbours_of(i, {w, h}) end)
    # count neighbour occurances
    |> Enum.frequencies()
    # filter live neighbours
    |> Enum.reduce(%{}, fn {i, count}, acc ->
      case Map.get(state, i, :dead) do
        :live ->
          cond do
            count >= 2 and count <= 3 -> Map.put(acc, i, :live)
            true -> acc
          end

        :dead ->
          cond do
            count == 3 -> Map.put(acc, i, :live)
            true -> acc
          end
      end
    end)
  end

  def toggle_position(%Board{state: state} = board, index) do
    %Board{board | state: toogle_position_state(state, index), generation: 0}
  end

  defp toogle_position_state(state, index) when not is_list(index),
    do: toogle_position_state(state, [index])

  defp toogle_position_state(state, []), do: state

  defp toogle_position_state(state, [index | indexes]) do
    state =
      case Map.get(state, index, :dead) do
        :live -> set_position_state(state, index, :dead)
        :dead -> set_position_state(state, index, :live)
      end

    toogle_position_state(state, indexes)
  end

  defp set_position_state(state, index, :live), do: Map.put(state, index, :live)
  defp set_position_state(state, index, :dead), do: Map.delete(state, index)
end
