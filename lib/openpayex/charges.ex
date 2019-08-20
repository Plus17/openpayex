defmodule Openpayex.Charges do
  @moduledoc """
  Functions for working with charges at Openpay. Through this API you can:

  * create a charge
  * get a charge
  * list charges
  """

  alias Openpayex.OpenPay.OpenPayHelper

  @doc """
  Create charge without client.

  ## Example:
  ```
  params = %{
    method: "bank_account",
    amount: 100,
    description: "Cargo con banco",
    order_id: "oid-00055",
    customer: %{
      name: "Soy un cliente",
      email: "email@email.com"
    }
  }

  iex> Openpayex.Charges.create(params)
  {:ok, response}
  ```
  """
  @spec create(map) :: {:ok, map}
  def create(%{
    method: _method,
    amount: amount,
    description: _description,
    order_id: _order_id,
    customer: customer
  } = params) when is_integer(amount) or is_float(amount) and is_map(customer) do
    endpoint = "/#{_get_merchant_id()}/charges"
    OpenPayHelper.http_request(:post, endpoint, params)
  end

  def create(_params), do: {:error, :bad_params}

  @doc """
  Create charge with client

  ## Example:
  ```
  params = %{
    method: "bank_account",
    amount: 100,
    description: "Cargo con banco",
    order_id: "oid-00055"
  }

  customer_id = "aqkd4esexqlkofk6utec"

  iex> Openpayex.Charges.create_with_customer(params, customer_id)
  {:ok, response}
  ```
  """
  @spec create_with_customer(map, String.t) :: {:ok, map}
  def create_with_customer(%{
    method: _method,
    amount: amount,
    description: _description,
    order_id: _order_id
  } = params, customer_id) when is_integer(amount) or is_float(amount) and is_binary(customer_id) do
    endpoint = "/#{_get_merchant_id()}/customers/#{customer_id}/charges"
    OpenPayHelper.http_request(:post, endpoint, params)
  end

  def create_with_client(_params), do: {:error, :bad_params}

  @doc """
  Get charge
  """
  @spec get(String.t) :: {:ok, map}
  def get(transaction_id) when is_binary(transaction_id) do
    endpoint = "/#{_get_merchant_id()}/charges/#{transaction_id}"
    OpenPayHelper.http_request(:get, endpoint)
  end

  def get(%{
    transaction_id: transaction_id,
    customer_id: customer_id
  }) when is_binary(transaction_id) and is_binary(customer_id) do
    endpoint = "/#{_get_merchant_id()}/customers/#{customer_id}/charges/#{transaction_id}"
    OpenPayHelper.http_request(:get, endpoint)
  end

  @doc """
  List charges
  """
  @spec list() :: {:ok, [map]}
  def list() do
    endpoint = "/#{_get_merchant_id()}/charges"
    OpenPayHelper.http_request(:get, endpoint)
  end

  # Get a merchant id
  @spec _get_merchant_id() :: Strint.t()
  defp _get_merchant_id() do
    if Mix.env() == :test do
      "test_merchant_id"
    else
      Application.get_env(:openpayex, :merchant_id)
    end
  end
end
