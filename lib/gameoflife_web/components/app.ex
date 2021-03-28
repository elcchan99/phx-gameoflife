defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias GameoflifeWeb.Components.Board

  @width 120
  @height 60

  prop width, :number, default: @width
  prop height, :number, default: @height

  data board_state, :list

  def render(assigns) do
    ~H"""
      <div id="gameoflife">
        <h1>Game of Life</h1>
        <Board
          width={{@width}}
          height={{@height}}
          state={{@board_state}}/>
      </div>
    """
  end

  def mount(socket) do
    {:ok, assign(socket, board_state: initial_board_state())}
  end
end
