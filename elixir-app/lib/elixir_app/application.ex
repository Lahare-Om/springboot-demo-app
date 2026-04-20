defmodule ElixirApp.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, [scheme: :http, plug: ElixirApp.Router, options: [port: 8080]]}
    ]

    IO.puts("Elixir App starting on port 8080")
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
