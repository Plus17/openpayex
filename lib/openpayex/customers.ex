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
  {:ok,
    %{
      "address" => nil,
      "clabe" => nil,
      "creation_date" => "2019-06-18T18:34:32-05:00",
      "email" => "customer_email@me.com",
      "external_id" => nil,
      "id" => "a8ujqsvn9e642lhpa6uj",
      "last_name" => nil,
      "name" => "customer name",
      "phone_number" => nil
    }
  }
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
  {:ok,
    %{
      "address" => %{
        "city" => "Queretaro",
        "country_code" => "MX",
        "line1" => "Calle 10",
        "line2" => "col. san pablo",
        "line3" => "entre la calle 1 y la 2",
        "postal_code" => "76000",
        "state" => "Queretaro"
      },
      "clabe" => nil,
      "creation_date" => "2019-06-18T18:18:14-05:00",
      "email" => "customer_email@me.com",
      "external_id" => nil,
      "id" => "a4wgoshubzmsjqujdsig",
      "last_name" => nil,
      "name" => "customer name",
      "phone_number" => "44209087654"
    }
  }
  ```
  """
  @spec update(map, String.t()) :: {:ok, map}
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
  {:ok,
    %{
      "address" => %{
        "city" => "Queretaro",
        "country_code" => "MX",
        "line1" => "Calle 10",
        "line2" => "col. san pablo",
        "line3" => "entre la calle 1 y la 2",
        "postal_code" => "76000",
        "state" => "Queretaro"
      },
      "clabe" => nil,
      "creation_date" => "2019-06-18T18:18:14-05:00",
      "email" => "customer_email@me.com",
      "external_id" => nil,
      "id" => "a4wgoshubzmsjqujdsig",
      "last_name" => nil,
      "name" => "customer name",
      "phone_number" => "44209087654"
    }
  }
  ```
  """
  @spec get(String.t()) :: {:ok, map}
  def get(customer_id) do
    endpoint = "/#{_get_merchant_id()}/customers/#{customer_id}"
    OpenPayHelper.http_request(:get, endpoint)
  end

  @doc """
  Delete a customer

  ## Example;
  ```
  customer_id = "a4wgoshubzmsjqujdsig"

  iex> Openpayex.Customers.delete(customer_id)
  {:ok, ""}
  ```
  """
  @spec delete(String.t()) :: {:ok, String.t()}
  def delete(customer_id) do
    endpoint = "/#{_get_merchant_id()}/customers/#{customer_id}"
    OpenPayHelper.http_request(:delete, endpoint)
  end

  @doc """
  List client

  ## Example;
  ```
  iex> Openpayex.Customers.list()
  {:ok,
    [
      %{
        "address" => nil,
        "clabe" => nil,
        "creation_date" => "2019-06-17T21:57:47-05:00",
        "email" => "customer_email@me.com",
        "external_id" => nil,
        "id" => "a6hcwapaceqdxgrmqvfo",
        "last_name" => nil,
        "name" => "customer name",
        "phone_number" => nil
      },
      %{
        "address" => nil,
        "clabe" => nil,
        "creation_date" => "2019-06-17T21:54:24-05:00",
        "email" => "customer_email@me.com",
        "external_id" => nil,
        "id" => "abzaacjwlfaig45bec3m",
        "last_name" => nil,
        "name" => "customer name",
        "phone_number" => nil
      }
    ]
  }

  iex> Openpayex.Customers.list(%{limit: 1})
  {:ok,
    [
      %{
        "address" => nil,
        "clabe" => nil,
        "creation_date" => "2019-06-17T21:57:47-05:00",
        "email" => "customer_email@me.com",
        "external_id" => nil,
        "id" => "a6hcwapaceqdxgrmqvfo",
        "last_name" => nil,
        "name" => "customer name",
        "phone_number" => nil
      }
    ]
  }
  ```
  """
  @spec list(map) :: {:ok, map}
  def list(params \\ %{}) do
    endpoint = "/#{_get_merchant_id()}/customers"

    endpoint_with_filters = _add_query_params(endpoint, params)

    OpenPayHelper.http_request(:get, endpoint_with_filters)
  end

  # Adds query params to endpoint
  @spec _add_query_params(String.t(), map) :: String.t()
  defp _add_query_params(url, params) do
    query_params = URI.encode_query(params)

    url
    |> URI.parse()
    |> Map.put(:query, query_params)
    |> URI.to_string()
  end

  # Get a merchant id
  @spec _get_merchant_id() :: Strint.t()
  defp _get_merchant_id() do
    Application.get_env(:openpayex, :merchant_id)
  end
end
