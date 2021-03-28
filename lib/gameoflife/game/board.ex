defmodule Gameoflife.Game.Board do
  alias Gameoflife.Game.Board
  alias Gameoflife.Game.Cell

  defstruct width: 10, height: 20, state: nil

  defguard is_inbound(i, size) when i >= 0 and i < size

  def new(width, height) do
    %Board{width: width, height: height, state: initial_board_state(width * height)}
    |> set_horizontal_line(div(height, 2))
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

  # defp set_cell_state(a, b, c) do
  #   IO.inspect(a, label: "board")
  #   IO.inspect(b, label: "index")
  #   IO.inspect(c, label: "state")
  #   a
  # end

  # def next(%Board{state: state}=board) do
  #   new_state = Enum.map()
  # end

  def neighbours_of(%Board{width: w, height: h}, i) do
    t = neighbour_top(w, h, i)
    b = neighbour_bottom(w, h, i)
    l = neighbour_left(w, h, i)
    r = neighbour_right(w, h, i)

    [
      neighbour_left(w, h, t),
      t,
      neighbour_right(w, h, t),
      l,
      r,
      neighbour_left(w, h, b),
      b,
      neighbour_right(w, h, b)
    ]
    |> Enum.filter(&(&1 != nil))
  end

  def neighbour_top(w, h, i) when is_integer(i) and is_inbound(i - w, w * h), do: i - w
  def neighbour_top(_, _, _), do: nil
  def neighbour_bottom(w, h, i) when is_integer(i) and is_inbound(i + w, w * h), do: i + w
  def neighbour_bottom(_, _, _), do: nil

  def neighbour_left(w, h, i)
      when is_integer(i) and rem(i, w) != 0 and is_inbound(i - 1, w * h),
      do: i - 1

  def neighbour_left(_, _, _), do: nil

  def neighbour_right(w, h, i)
      when is_integer(i) and rem(i + 1, w) != 0 and is_inbound(i + 1, w * h),
      do: i + 1

  def neighbour_right(_, _, _), do: nil
end
