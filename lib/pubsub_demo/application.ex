defmodule PubsubDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PubsubDemoWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:pubsub_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PubsubDemo.PubSub},
      # Start a worker by calling: PubsubDemo.Worker.start_link(arg)
      # {PubsubDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      PubsubDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PubsubDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PubsubDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
