defmodule GameoflifeWeb.Components.ButtonSeed do
  use Surface.Component

  @doc "Triggers on click"
  prop on_click, :event, required: true

  @doc "Seed name"
  prop name, :string, required: true

  @doc "Seed function name"
  prop seed, :string, required: true

  def render(assigns) do
    ~H"""
    <button :on-click={{ @on_click }}
      phx-value-command-group="seed"
      phx-value-command={{@seed}}>
      {{@name}}</button>
    """
  end
end
