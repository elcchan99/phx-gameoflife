defmodule GameoflifeWeb.Components.CommandPanel do
  use Surface.Component

  @doc "Triggers on click"
  prop on_command_click, :event

  def render(assigns) do
    ~H"""
      <div class="command-panel">
        <button :on-click={{ @on_command_click }} phx-value-command="step">Step</button>
      </div>
    """
  end
end
