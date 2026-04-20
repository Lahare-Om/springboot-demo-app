defmodule ElixirApp.Router do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    case conn.request_path do
      "/" -> handle_index(conn)
      "/health" -> handle_health(conn)
      _ -> send_resp(conn, 404, Jason.encode!(%{error: "Not found"}))
    end
  end

  defp handle_index(conn) do
    response = Jason.encode!(%{message: "Hello from Elixir App", version: "1.0.0"})
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, response)
  end

  defp handle_health(conn) do
    hostname = elem(System.cmd("hostname", []), 0) |> String.trim()
    response = Jason.encode!(%{status: "healthy", hostname: hostname})
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, response)
  end
end
