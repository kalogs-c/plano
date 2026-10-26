defmodule Plano.Repo do
  use Ecto.Repo,
    otp_app: :plano,
    adapter: Ecto.Adapters.Postgres
end
