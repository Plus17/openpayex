defmodule Openpayex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = []

    children =
      if Mix.env() == :test do
        [
          Plug.Cowboy.child_spec(
            scheme: :http,
            plug: Openpayex.OpenPay.ClientMockServer,
            options: [port: 8084]
          )
        ] ++ children
      else
        children
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Openpayex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
