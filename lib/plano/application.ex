defmodule Plano.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PlanoWeb.Telemetry,
      Plano.Repo,
      {DNSCluster, query: Application.get_env(:plano, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Plano.PubSub},
      # Start a worker by calling: Plano.Worker.start_link(arg)
      # {Plano.Worker, arg},
      # Start to serve requests, typically the last entry
      PlanoWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Plano.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PlanoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
