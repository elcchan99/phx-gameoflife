defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias Gameoflife.Game.Board, as: BoardStruct

  alias GameoflifeWeb.Components.Board
  alias GameoflifeWeb.Components.CommandPanel
  alias GameoflifeWeb.Components.InfoPanel

  @width 60
  @height 30

  prop width, :number, default: @width
  prop height, :number, default: @height

  data board, :module, default: BoardStruct.new(@width, @height)

  def render(assigns) do
    ~H"""
      <div id="gameoflife">
        <h1>Game of Life</h1>
        <div class="board-wrapper center">
          <Board value={{@board}}/>
        </div>
        <div class="sider">
          <InfoPanel generation={{@board.generation}}/>
          <CommandPanel
            on_command_click="command"/>
        </div>
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
