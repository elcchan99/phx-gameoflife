defmodule Gameoflife.Game.BoardAgent do
  use Agent

  alias Gameoflife.Game.Board

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def reset(board) do
    Agent.update(__MODULE__, fn _ -> board end)
    next()
  end

  def next do
    Agent.get_and_update(__MODULE__, fn board -> {board, Board.next(board)} end)
  end
end
