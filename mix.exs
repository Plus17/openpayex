defmodule Openpayex.MixProject do
  use Mix.Project

  def project do
    [
      app: :openpayex,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {Openpayex.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:jason, "~> 1.1"},
      {:httpoison, "~> 1.4"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
