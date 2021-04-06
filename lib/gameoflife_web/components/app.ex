defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias Gameoflife.Game.Board, as: BoardStruct

  alias GameoflifeWeb.Components.Board
  alias GameoflifeWeb.Components.CommandPanel

  @width 60
  @height 30

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

  def mount(socket) do
    socket = Surface.init(socket)
    {:ok, socket}
  end

  def handle_event(
        "command",
        %{"command" => "step"} = _params,
        %{assigns: %{board: board}} = socket
      ) do
    {:noreply, socket |> assign(board: BoardStruct.next(board))}
  end
end
