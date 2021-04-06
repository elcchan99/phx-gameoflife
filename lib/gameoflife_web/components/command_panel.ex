defmodule GameoflifeWeb.Components.CommandPanel do
  use Surface.Component

  alias GameoflifeWeb.Components.ButtonSeed

  @doc "Triggers on click"
  prop on_command_click, :event

  def render(assigns) do
    ~H"""
      <div class="command-panel">
        <div class="start">
          <h4>Seeds</h4>
          <ButtonSeed on_click={{ @on_command_click }} name="Horizontal" seed="horizontal"/>
          <ButtonSeed on_click={{ @on_command_click }} name="Block" seed="block"/>
          <ButtonSeed on_click={{ @on_command_click }} name="Bee Hive" seed="bee-hive"/>
          <ButtonSeed on_click={{ @on_command_click }} name="Loaf" seed="loaf"/>
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
