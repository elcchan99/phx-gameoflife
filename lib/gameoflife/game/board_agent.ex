defmodule Gameoflife.Game.BoardAgent do
  use Agent

  alias Gameoflife.Game.Board

  def start_link(initial_value) do
    Agent.start_link(
      fn -> set_state(initial_value) end,
      name: __MODULE__
    )
  end

  defp set_state(value) do
    %{
      current: value,
      next: Board.next(value)
    }
  end

  def value do
    %{current: current} = Agent.get(__MODULE__, & &1)
    current
  end

  def reset(board) do
    Agent.update(__MODULE__, fn _ -> set_state(board) end)
    value()
  end

  def next do
    %{next: next} =
      Agent.get_and_update(__MODULE__, fn %{next: next} = state -> {state, set_state(next)} end)

    next
  end

  def toggle(index) do
    value() |> Board.toggle_position(index) |> reset()
  end
end
