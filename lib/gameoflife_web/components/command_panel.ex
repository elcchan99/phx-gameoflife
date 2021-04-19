defmodule GameoflifeWeb.Components.CommandPanel do
  use Surface.Component

  alias GameoflifeWeb.Components.ButtonSeed

  @doc "Triggers on click"
  prop on_command_click, :event

  @doc "Config of seed buttons"
  prop seeds_config, :list

  def render(assigns) do
    ~H"""
      <div class="command-panel">
        <div class="seed">
          <h4>Seeds</h4>
          <ButtonSeed on_click={{ @on_command_click }}
            :for={{ config <- @seeds_config }}
            config={{config}}/>
        </div>
        <div class="action">
          <h4>Actions</h4>
          <button :on-click={{ @on_command_click }}
            phx-value-command-group="action"
            phx-value-command="clear">Clear</button>
          <button :on-click={{ @on_command_click }}
            phx-value-command-group="action"
            phx-value-command="step">Step</button>
          <button :on-click={{ @on_command_click }}
            phx-value-command-group="action"
            phx-value-command="auto">Auto</button>
          <button :on-click={{ @on_command_click }}
            phx-value-command-group="action"
            phx-value-command="stop">Stop</button>
        </div>
      </div>
    """
  end
end
