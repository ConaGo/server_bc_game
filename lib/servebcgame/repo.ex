defmodule Servebcgame.Repo do
  use Ecto.Repo,
    otp_app: :servebcgame,
    adapter: Ecto.Adapters.Postgres
end
