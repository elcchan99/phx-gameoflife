defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias Gameoflife.Game.Board, as: BoardStruct
  alias Gameoflife.Game.Seed, as: BoardSeed

  alias GameoflifeWeb.Components.Board
  alias GameoflifeWeb.Components.CommandPanel
  alias GameoflifeWeb.Components.InfoPanel

  @width 60
  @height 30

  prop width, :number, default: @width
  prop height, :number, default: @height
  prop debug, :boolean, default: true

  data board, :module, default: BoardStruct.new(@width, @height)

  def render(assigns) do
    ~H"""
      <div id="gameoflife">
        <h1>Game of Life</h1>
        <div class="board-wrapper center">
          <Board value={{@board}} debug={{@debug}}/>
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
        %{"command-group" => "action", "command" => "step"} = _params,
        %{assigns: %{board: board}} = socket
      ) do
    {:noreply, socket |> assign(board: BoardStruct.next(board))}
  end

  def handle_event(
        "command",
        %{"command-group" => "seed", "command" => command} = _params,
        %{assigns: %{board: board}} = socket
      ) do
    {:noreply,
     socket
     |> assign(board: BoardStruct.new(board.width, board.height, seed_fn(command)))}
  end

  defp seed_fn("horizontal"), do: &BoardSeed.horizontal_line_at_center/3
  defp seed_fn("block"), do: &BoardSeed.StillLife.block_at_center/3
end
