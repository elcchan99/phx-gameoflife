defmodule GameoflifeWeb.Components.Board do
  use Surface.Component

  @doc "board width"
  prop width, :number, required: true

  @doc "board height"
  prop height, :number, required: true

  @doc "board state"
  prop state, :list, required: true

  def render(assigns) do
    ~H"""
      <div class="board">
        <div class="row row-{{row_index}}" :for={{ {row, row_index} <- (Enum.chunk_every(@state, @width) |> Enum.with_index()) }}>
          <div class="cell col-{{col_index}}" :for={{ {cell, col_index} <- Enum.with_index(row)}}>
            {{cell}}
          </div>
        </div>
      </div>
    """
  end
end
