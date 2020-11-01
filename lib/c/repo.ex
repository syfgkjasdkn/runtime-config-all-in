defmodule C.Repo do
  use Ecto.Repo,
    otp_app: :c,
    adapter: Ecto.Adapters.Postgres
end
