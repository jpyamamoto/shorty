defmodule Shorty.Repo do
  use Ecto.Repo,
    otp_app: :shorty,
    adapter: Ecto.Adapters.SQLite3
end
