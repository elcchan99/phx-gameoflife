defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias Gameoflife.Game.BoardAgent
  alias Gameoflife.Game.Board, as: BoardStruct

  alias GameoflifeWeb.Components.Board
  alias GameoflifeWeb.Components.CommandPanel
  alias GameoflifeWeb.Components.InfoPanel

  alias(GameoflifeWeb.Components.ButtonSeed, as: ButtonSeedConfig)

  alias Gameoflife.Game.Seeder
  alias Gameoflife.Game.Seed.HorizontalLine, as: HorizontalLineSeed
  alias Gameoflife.Game.Seed.StillLife, as: StillLifeSeed
  alias Gameoflife.Game.Seed.Oscillator, as: OscillatorSeed
  alias Gameoflife.Game.Seed.Spaceship, as: SpaceshipSeed

  @width 100
  @height 70

  prop width, :number, default: @width
  prop height, :number, default: @height
  prop debug, :boolean, default: false

  data board, :module, default: BoardStruct.new(@width, @height)

  prop timer_interval, :number, default: 500
  data timer, :string, default: nil

  @seed_map %{
    "horizontal" => HorizontalLineSeed,
    "block" => StillLifeSeed.Block,
    "bee-hive" => StillLifeSeed.BeeHive,
    "loaf" => StillLifeSeed.Loaf,
    "boat" => StillLifeSeed.Boat,
    "tub" => StillLifeSeed.Tub,
    "blinker" => OscillatorSeed.Blinker,
    "toad" => OscillatorSeed.Toad,
    "beacon" => OscillatorSeed.Beacon,
    "glider" => SpaceshipSeed.Glider
  }

  @seed_btn_cfg @seed_map
                |> Enum.reduce([], fn {key, seed}, acc ->
                  [%ButtonSeedConfig{name: seed.display_name(), seed: key} | acc]
                end)
                |> Enum.sort(&(&1.name <= &2.name))

  prop seeds_config, :map, default: @seed_btn_cfg

  def render(assigns) do
    ~H"""
      <div id="gameoflife">
        <h1>Game of Life</h1>
        <div class="board-wrapper center">
          <Board value={{@board}} debug={{@debug}} on_cell_click="cell-click"/>
        </div>
        <div class="sider">
          <InfoPanel generation={{@board.generation}}/>
          <CommandPanel
            on_command_click="command"
            seeds_config={{@seeds_config}}/>
        </div>
      </div>
    """
  end

  def mount(socket) do
    socket = Surface.init(socket)
    %{assigns: %{board: board}} = socket
    BoardAgent.start_link(board)
    {:ok, socket |> assign(board: BoardAgent.value())}
  end

  def handle_event(
        "command",
        %{"command-group" => "action", "command" => "clear"} = _params,
        socket
      ) do
    {:noreply, socket |> assign(board: initiate_board(@width, @height))}
  end

  def handle_event(
        "command",
        %{"command-group" => "action", "command" => "step"} = _params,
        socket
      ) do
    send(self(), :step)
    {:noreply, socket}
  end

  def handle_event(
        "command",
        %{"command-group" => "action", "command" => "auto"} = _params,
        %{assigns: %{timer_interval: interval}} = socket
      ) do
    {:ok, timer} = :timer.send_interval(interval, self(), :step)
    {:noreply, socket |> assign(timer: timer)}
  end

  def handle_event(
        "command",
        %{"command-group" => "action", "command" => "stop"} = _params,
        %{assigns: %{timer: timer}} = socket
      ) do
    :timer.cancel(timer)
    {:noreply, socket |> assign(timer: nil)}
  end

  def handle_event(
        "command",
        %{"command-group" => "seed", "command" => command} = _params,
        %{assigns: %{board: board}} = socket
      ) do
    {:noreply, socket |> assign(board: initiate_board(board.width, board.height, command))}
  end

  def handle_event(
        "cell-click",
        %{"index" => index} = _params,
        socket
      ) do
    {:noreply,
     socket
     |> assign(board: BoardAgent.toggle(String.to_integer(index)))}
  end

  defp seed_fn(key) do
    case Map.get(@seed_map, key, nil) do
      nil -> fn _, _ -> %{} end
      seed -> &Seeder.apply(seed, &1, &2)
    end
  end

  defp initiate_board(width, height, seed_key \\ "") do
    BoardStruct.new(width, height, seed_fn(seed_key)) |> BoardAgent.reset()
  end
end
