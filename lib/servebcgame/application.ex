defmodule Servebcgame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Servebcgame.Repo,
      # Start the Telemetry supervisor
      ServebcgameWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Servebcgame.PubSub},
      # Start the Presence system
      ServebcgameWeb.Presence,
      # Start the Endpoint (http/https)
      ServebcgameWeb.Endpoint
      # Start a worker by calling: Servebcgame.Worker.start_link(arg)
      # {Servebcgame.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Servebcgame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ServebcgameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
