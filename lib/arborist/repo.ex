defmodule Arborist.Repo do
  use Ecto.Repo,
    otp_app: :arborist,
    adapter: Ecto.Adapters.Postgres
end
