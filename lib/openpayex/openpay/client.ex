defmodule Openpayex.OpenPay.Client do
  @moduledoc """
  Client for OpenPay API
  """

  use HTTPoison.Base

  defp _base_url() do
    if Mix.env() == :test do
      "http://localhost:8084"
    else
      Application.get_env(:openpayex, :uri_base)
    end
  end

  def process_url(endpoint) do
    "#{_base_url()}#{endpoint}"
  end

  def process_request_headers(_headers) do
    [
      {"Content-Type", "application/json"}
    ]
  end

  def process_request_options(_options) do
    credentials = Application.get_env(:openpayex, :private_key)
    [hackney: [basic_auth: {"#{credentials}:", ""}]]
  end

  def process_request_body(body) do
    Jason.encode!(body)
  end

  def process_response_body(""), do: ""

  def process_response_body(body) do
    Jason.decode!(body)
  end
end
