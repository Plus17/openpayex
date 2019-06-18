defmodule Openpayex.Customers do
  @moduledoc """
  Functions for working with customers at Openpay. Through this API you can:

  * create a customer
  * get a customer
  * delete a customer
  * list customers
  """

  alias Openpayex.OpenPay.OpenPayHelper

  @doc """
  Create a customer

  ## Example:
  ```
  params = %{
   "name": "customer name",
   "email": "customer_email@me.com",
   "requires_account": false
   }

  iex> Openpayex.Customers.create(params)
  {:ok, response}
  ```
  """
  @spec create(map) :: map
  def create(params) do
    endpoint = "/#{_get_merchant_id()}/customers"
    OpenPayHelper.http_request(:post, endpoint, params)
  end

  # Get a merchant id
  @spec _get_merchant_id() :: Strint.t()
  defp _get_merchant_id() do
    Application.get_env(:openpayex, :merchant_id)
  end
end
