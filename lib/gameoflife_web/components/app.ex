defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias GameoflifeWeb.Components.Board
  alias GameoflifeWeb.Components.CommandPanel

  @width 120
  @height 60

  prop width, :number, default: @width
  prop height, :number, default: @height

  data board_state, :list

  def render(assigns) do
    ~H"""
      <div id="gameoflife">
        <h1>Game of Life</h1>
        <CommandPanel
          on_command_click="command"/>
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

  def initial_board_state(), do: Enum.to_list(0..(@width * @height - 1))

  def handle_event(
        "command",
        %{"command" => "step"} = _params,
        %{assigns: %{board_state: _board_state}} = socket
      ) do
    # IO.inspect(params, label: "params")
    # IO.inspect(board_state, label: "board_state")
    IO.puts("Step")
    {:noreply, socket}
  end
end
