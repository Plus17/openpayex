defmodule OpenPayEx.Charges do
  @moduledoc """
  Functions for working with charges at Openpay. Through this API you can:

  * create a charge
  * get a charge
  * list charges
  """

  alias OpenPayEx.OpenPay.OpenPayHelper

  @doc """
  Create charge without client

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

  iex> Charges.create(params)
  {:ok, response}
  ```
  """
  @spec create(map) :: map
  def create(%{
    method: _method,
    amount: amount,
    description: _description,
    order_id: _order_id,
    customer: %{}
  } = params) when is_integer(amount) or is_float(amount) do
    endpoint = "/#{_get_merchant_id()}/charges"
    OpenPayHelper.http_request(:post, endpoint, params)
  end

  def create(%{
    method: _method,
    amount: amount,
    description: _description,
    order_id: _order_id,
    customer_id: customer_id
  } = params) when is_integer(amount) or is_float(amount) and is_binary(customer_id) do
    endpoint = "/#{_get_merchant_id()}/customers/#{customer_id}/charges"
    params = Map.drop(params, [:customer_id])
    OpenPayHelper.http_request(:post, endpoint, params)
  end

  def create(_params), do: {:error, :bad_params}

  @doc """
  Get charge
  """
  @spec get(String.t) :: map
  def get(charge_id) when is_binary(charge_id) do
    endpoint = "/#{_get_merchant_id()}/charges/#{charge_id}"
    OpenPayHelper.http_request(:get, endpoint)
  end

  # Get a merchant id
  @spec _get_merchant_id() :: Strint.t()
  defp _get_merchant_id() do
    Application.get_env(:openpayex, :merchant_id)
  end
end
