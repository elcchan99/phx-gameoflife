defmodule Gameoflife.Game.Seed.Utils do
  def calc_center(n) when rem(n, 2) == 0, do: div(n, 2) - 1
  def calc_center(n), do: div(n, 2)
  def calc_center_center({w, h}), do: calc_center(h) * w + calc_center(w)
end
