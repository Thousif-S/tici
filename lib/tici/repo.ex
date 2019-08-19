defmodule Tici.Repo do
  use Ecto.Repo,
    otp_app: :tici,
    adapter: Ecto.Adapters.Postgres
end
