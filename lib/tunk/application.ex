defmodule Tunk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Tunk.Config.load(Fig.Loader.Env)

    children = [
      worker(Hull.Ticker, [Tunk, 10_000])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tunk.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
