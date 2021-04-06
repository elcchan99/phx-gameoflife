defmodule GameoflifeWeb.Components.InfoPanel do
  use Surface.Component

  @doc "generation of game"
  prop generation, :number, default: 0

  def render(assigns) do
    ~H"""
      <div class="info-panel">
        <span class="generation">Generation: {{@generation}}</span>
      </div>
    """
  end
end
