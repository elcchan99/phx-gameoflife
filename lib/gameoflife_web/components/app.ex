defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

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

  @width 60
  @height 30

  prop width, :number, default: @width
  prop height, :number, default: @height
  prop debug, :boolean, default: true

  data board, :module, default: BoardStruct.new(@width, @height)

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
          <Board value={{@board}} debug={{@debug}}/>
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

  defp seed_fn(key) do
    case Map.get(@seed_map, key, nil) do
      nil -> fn _, _ -> %{} end
      seed -> &Seeder.apply(seed, &1, &2)
    end
  end
end
