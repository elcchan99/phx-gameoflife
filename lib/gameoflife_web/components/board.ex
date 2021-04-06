defmodule GameoflifeWeb.Components.Board do
  use Surface.Component

  alias GameoflifeWeb.Components.Cell

  @doc "board state"
  prop value, :module, required: true

  prop debug, :boolean, default: false

  def render(assigns) do
    ~H"""
      <div class="board">
        <div class="row row-{{row_index}}" :for={{ row_index <- 0..@value.height-1 }}>
          <Cell
            :for={{ col_index <- 0..@value.width-1}}
            class="col-{{col_index}}"
            index={{row_index * @value.width + col_index}}
            state={{cell_at(@value.state, row_index * @value.width + col_index)}}
            debug={{@debug}}/>
        </div>
      </div>
    """
  end

  defp cell_at(state, index) do
    state
    |> Map.get(index, :dead)
  end
end
