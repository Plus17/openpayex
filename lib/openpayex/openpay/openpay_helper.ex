defmodule Openpayex.OpenPay.OpenPayHelper do
  @moduledoc """
  Methods for OpenPay Client
  """

  alias Openpayex.OpenPay.Client

  @success_status_codes [200, 201, 204]

  @doc """
  Make a request
  """
  @spec http_request(atom, String.t, map) :: {:ok, map} | {:error, map}
  def http_request(method, endpoint, params \\ %{}) do
    method
    |> Client.request(endpoint, params)
    |> IO.inspect(label: "RESPONSE")
    |> _process_response()
  end

  # Process HTTP response
  @spec _process_response(map) :: {:ok, map} | {:error, map} | {:error, String.t}
  defp _process_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} when status_code in @success_status_codes ->
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
