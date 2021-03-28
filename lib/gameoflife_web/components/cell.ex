defmodule GameoflifeWeb.Components.Cell do
  use Surface.Component

  alias Gameoflife.Game.Cell, as: CellStruct

  prop state, :list, required: true

  def render(assigns) do
    ~H"""
    <div class="cell col-{{col_index}} {{render_cell_state(cell)}}"
      :for={{ {cell, col_index} <- Enum.with_index(@state)}}>
    </div>
    """
  end

  def render_cell_state(%CellStruct{state: :live}), do: "live"
  def render_cell_state(%CellStruct{state: _}), do: "dead"
end
