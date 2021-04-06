defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  alias Gameoflife.Game.Board, as: BoardStruct
  alias Gameoflife.Game.Seed, as: BoardSeed

  alias GameoflifeWeb.Components.Board
  alias GameoflifeWeb.Components.CommandPanel
  alias GameoflifeWeb.Components.InfoPanel

  alias(GameoflifeWeb.Components.ButtonSeed, as: ButtonSeedConfig)

  alias Gameoflife.Game.Seeder
  alias Gameoflife.Game.Seed.HorizontalLine, as: HorizontalLineSeed
  alias Gameoflife.Game.Seed.StillLife, as: StillLifeSeed

  @width 60
  @height 30

  prop width, :number, default: @width
  prop height, :number, default: @height
  prop debug, :boolean, default: true

  data board, :module, default: BoardStruct.new(@width, @height)

  @seed_map %{
    "horizontal" => {HorizontalLineSeed, "Horizontal"},
    "block" => {StillLifeSeed.Block, "Block"},
    "bee-hive" => {StillLifeSeed.BeeHive, "Bee Hive"},
    "loaf" => {StillLifeSeed.Loaf, "Loaf"},
    "boat" => {StillLifeSeed.Boat, "Boat"},
    "tub" => {StillLifeSeed.Tub, "Tub"}
  }

  @seed_btn_cfg @seed_map
                |> Enum.reduce([], fn {key, {_, name}}, acc ->
                  [%ButtonSeedConfig{name: name, seed: key} | acc]
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
    {seed, _} = Map.get(@seed_map, key, {&BoardSeed.empty/2, ""})
    &Seeder.apply(seed, &1, &2)
  end
end
