defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias Gameoflife.Game.Board, as: BoardStruct

  alias GameoflifeWeb.Components.Board
  alias GameoflifeWeb.Components.CommandPanel

  @width 120
  @height 60

  prop width, :number, default: @width
  prop height, :number, default: @height

  data board, :module, default: BoardStruct.new(@width, @height)

  def render(assigns) do
    ~H"""
      <div id="gameoflife">
        <h1>Game of Life</h1>
        <CommandPanel
          on_command_click="command"/>
        <Board value={{@board}}/>
      </div>
    """
  end

  def handle_event(
        "command",
        %{"command" => "step"} = params,
        %{assigns: %{board: board}} = socket
      ) do
    IO.inspect(params, label: "params")
    IO.inspect(board, label: "board")
    IO.puts("Step")
    {:noreply, socket}
  end
end
