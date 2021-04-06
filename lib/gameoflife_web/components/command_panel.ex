defmodule GameoflifeWeb.Components.CommandPanel do
  use Surface.Component

  @doc "Triggers on click"
  prop on_command_click, :event

  def render(assigns) do
    ~H"""
      <div class="command-panel">
        <div class="start">
          <h4>Starter</h4>
          <button :on-click={{ @on_command_click }}
            phx-value-command-group="seed"
            phx-value-command="horizontal">
            Horizontal line</button>
          <button :on-click={{ @on_command_click }}
            phx-value-command-group="seed"
            phx-value-command="block">
            Block</button>
        </div>
        <div class="action">
          <h4>Actions</h4>
          <button :on-click={{ @on_command_click }}
            phx-value-command-group="action"
            phx-value-command="step">Step</button>
        </div>
      </div>
    """
  end
end
