defmodule GameoflifeWeb.Components.Board do
  use Surface.Component

  alias GameoflifeWeb.Components.Cell

  @doc "board state"
  prop value, :module, required: true

  def render(assigns) do
    ~H"""
      <div class="board">
        <div class="row row-{{row_index}}" :for={{ {row, row_index} <- (Enum.chunk_every(@value.state, @value.width) |> Enum.with_index()) }}>
          <Cell state={{row}}/>
        </div>
      </div>
    """
  end
end
