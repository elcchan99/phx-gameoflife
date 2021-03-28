defmodule Gameoflife.Repo do
  use Ecto.Repo,
    otp_app: :gameoflife,
    adapter: Ecto.Adapters.Postgres
end
