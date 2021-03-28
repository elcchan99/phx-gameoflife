defmodule GameoflifeWeb.Components.Cell do
  use Surface.Component

  prop state, :list, required: true

  def render(assigns) do
    ~H"""
    <div class="cell col-{{col_index}}" :for={{ {_, col_index} <- Enum.with_index(@state)}}>

    </div>
    """
  end
end