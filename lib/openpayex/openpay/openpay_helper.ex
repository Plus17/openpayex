defmodule OpenPayEx.OpenPay.OpenPayHelper do
  @moduledoc """
  Methods for OpenPay Client
  """

  alias OpenPayEx.OpenPay.Client

  @doc """
  Make a request
  """
  @spec http_request(atom, String.t, map) :: {:ok, map} | {:error, map}
  def http_request(method, endpoint, params) do
    method
    |> Client.request(endpoint, params)
    |> _process_response()
  end

  # Process HTTP response
  @spec _process_response(map) :: {:ok, map} | {:error, map} | {:error, String.t}
  defp _process_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 500, body: body}} ->
        {:error, body}
      {:ok, %HTTPoison.Response{status_code: _status_code, body: body}} ->
        {:error, body}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
