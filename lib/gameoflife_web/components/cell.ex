defmodule GameoflifeWeb.Components.Cell do
  use Surface.Component

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

  defp render_cell_state(:live), do: "live"
  defp render_cell_state(_), do: "dead"
end
