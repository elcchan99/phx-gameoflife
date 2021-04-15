defmodule GameoflifeWeb.AppLive do
  use GameoflifeWeb, :live_view

  alias Gameoflife.Game.BoardAgent

  alias GameoflifeWeb.Components.App

  def render(assigns) do
    ~H"""
    <App id="gameoflife"/>
    """
  end

  def handle_info(:step, socket) do
    send_update(self(), App, id: "gameoflife", board: BoardAgent.next())
    {:noreply, socket}
  end
end
