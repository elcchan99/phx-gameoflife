defmodule GameoflifeWeb.Components.Cell do
  use Surface.Component

  alias Gameoflife.Game.Cell, as: CellStruct

  @doc "HTML Class"
  prop class, :string, default: ""

  @doc "Cell index"
  prop index, :number, required: true

  @doc "Cell state"
  prop state, :module, required: true

  def render(assigns) do
    ~H"""
    <div class="cell {{@class}} {{render_cell_state(@state)}}">
    </div>
    """
  end

  def render_cell_state(%CellStruct{state: :live}), do: "live"
  def render_cell_state(%CellStruct{state: _}), do: "dead"
end
