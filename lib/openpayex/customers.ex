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

  @doc """
  Update a customer

  ## Example;
  ```
  params = %{
    "name" => "customer name",
    "email" => "customer_email@me.com",
    "address" => %{
      "city" =>"Queretaro",
      "state" =>"Queretaro",
      "line1" =>"Calle 10",
      "postal_code" =>"76000",
      "line2" =>"col. san pablo",
      "line3" =>"entre la calle 1 y la 2",
      "country_code" =>"MX"
    },
    "phone_number" => "44209087654"
  }

  customer_id = "a4wgoshubzmsjqujdsig"

  iex> Openpayex.Customers.update(params, customer_id)
  {:ok, response}
  ```
  """
  @spec update(map, String.t) :: {:ok, map}
  def update(params, customer_id) do
    endpoint = "/#{_get_merchant_id()}/customers/#{customer_id}"
    OpenPayHelper.http_request(:put, endpoint, params)
  end

  @doc """
  Get a customer

   ## Example;
  ```
  customer_id = "a4wgoshubzmsjqujdsig"

  iex> Openpayex.Customers.get(ustomer_id)
  {:ok, response}
  ```
  """
  @spec get(String.t) :: {:ok, map}
  def get(customer_id) do
    endpoint = "/#{_get_merchant_id()}/customers/#{customer_id}"
    OpenPayHelper.http_request(:get, endpoint)
  end

  # Get a merchant id
  @spec _get_merchant_id() :: Strint.t()
  defp _get_merchant_id() do
    Application.get_env(:openpayex, :merchant_id)
  end
end
