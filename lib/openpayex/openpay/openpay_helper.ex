defmodule OpenPayEx.OpenPay.OpenPayHelper do
  @moduledoc """
  Methods for OpenPay Client
  """
  require Logger

  alias OpenPayEx.OpenPay.Client

  @doc """
  Make a request
  """
  @spec http_request(atom, String.t, map) :: {:ok, map} | {:error, map}
  def http_request(:post, endpoint, params) do
    response = Client.post(endpoint, params)

    _process_response(response)
  end

  def http_request(:get, endpoint, params) do
    response = Client.get(endpoint, params)

    _process_response(response)
  end

  # Process HTTP response
  @spec _process_response(map) :: {:ok, map} | {:error, map} | {:error, String.t}
  defp _process_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info "Success request"
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
        Logger.error "Internal Server Error: #{body}"
        {:error, body}
      {:ok, %HTTPoison.Response{status_code: _status_code, body: body}} ->
        Logger.error "Error on request #{inspect(body)}"
        {:error, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error "Connection error #{reason}"
        {:error, reason}
    end
  end
end
