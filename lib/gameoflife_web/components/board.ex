defmodule GameoflifeWeb.Components.Board do
  use Surface.Component

  alias GameoflifeWeb.Components.Cell

  @doc "board state"
  prop value, :struct, required: true

  prop debug, :boolean, default: false

  @doc "Triggers on cell click"
  prop on_cell_click, :event

  def render(assigns) do
    ~H"""
      <div class="board" id="board" phx-hook="mouse_drag_hook">
        <div class="row row-{{row_index}}" :for={{ row_index <- 0..@value.height-1 }}>
          <Cell
            :for={{ col_index <- 0..@value.width-1}}
            class="col-{{col_index}}"
            index={{row_index * @value.width + col_index}}
            state={{cell_at(@value.state, row_index * @value.width + col_index)}}
            debug={{@debug}}
            on_click={{@on_cell_click}}/>
        </div>
      </div>
    """
  end

  defp cell_at(state, index) do
    state |> Map.get(index, :dead)
  end
end
