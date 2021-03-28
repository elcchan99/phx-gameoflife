defmodule GameoflifeWeb.AppLive do
  use GameoflifeWeb, :live_view

  alias GameoflifeWeb.Components.App

  def render(assigns) do
    ~H"""
    <App id="root"/>
    """
  end
end
