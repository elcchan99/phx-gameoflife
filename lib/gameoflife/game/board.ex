defmodule Gameoflife.Game.Board do
  alias Gameoflife.Game.BoardUtils
  alias Gameoflife.Game.Board
  alias Gameoflife.Game.Cell

  defstruct width: 10, height: 20, state: nil

  def new(width, height) do
    %Board{width: width, height: height, state: initial_board_state(width * height)}
    |> set_horizontal_line(div(height, 2))
  end

  def next(%Board{state: state} = board) do
    %Board{board | state: next_state(board, state)}
  end

  defp next_state(board, state) do
    state
    |> Enum.with_index()
    |> Enum.map(fn {cell, i} -> {cell, neighbours_of(board, i)} end)
    |> Enum.map(fn {cell, neighbours} -> Cell.next(cell, neighbours) end)
  end

  defp initial_board_state(size) do
    0..(size - 1)
    |> Enum.map(fn _ -> Cell.new() end)
    |> Enum.to_list()
  end

  defp set_horizontal_line(%{width: width, state: state} = board, row_index) do
    new_state =
      0..(width - 1)
      |> Enum.map(&(row_index * width + &1))
      |> Enum.reduce(state, fn i, acc -> set_cell_state(acc, i, :live) end)

    %Board{board | state: new_state}
  end

  defp set_cell_state(board_state, index, value) do
    new_cell =
      Enum.at(board_state, index)
      |> Cell.set_state(value)

    board_state |> List.replace_at(index, new_cell)
  end

  defp neighbours_of(%Board{width: w, height: h, state: state}, index) do
    BoardUtils.neighbours_of(w, h, index)
    |> Enum.map(&Enum.at(state, &1))
  end
end
