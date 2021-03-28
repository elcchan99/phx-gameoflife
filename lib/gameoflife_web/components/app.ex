defmodule GameoflifeWeb.Components.App do
  use Surface.LiveComponent

  def render(assigns) do
    ~H"""
      <section class="row">
        <h1>Hello World</h1>
      </section>
    """
  end
end
