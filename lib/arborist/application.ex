defmodule Arborist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ArboristWeb.Telemetry,
      # Start the Ecto repository
      Arborist.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Arborist.PubSub},
      # Start Finch
      {Finch, name: Arborist.Finch},
      # Start the Endpoint (http/https)
      ArboristWeb.Endpoint
      # Start a worker by calling: Arborist.Worker.start_link(arg)
      # {Arborist.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Arborist.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArboristWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
