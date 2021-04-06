defmodule GameoflifeWeb.Components.ButtonSeed do
  defstruct [:name, :seed]

  use Surface.Component

  @doc "Triggers on click"
  prop on_click, :event, required: true

  @doc "Seed button config"
  prop config, :struct, required: true

  def render(assigns) do
    ~H"""
    <button :on-click={{ @on_click }}
      phx-value-command-group="seed"
      phx-value-command={{@config.seed}}>
      {{@config.name}}</button>
    """
  end
end
