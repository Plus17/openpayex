defmodule Openpayex.OpenPay.ClientMockServer do
  @moduledoc false

  use Plug.Router
  plug Plug.Parsers, parsers: [:json],
                    pass:  ["text/*"],
                    json_decoder: Jason

  plug Plug.Logger
  plug :match
  plug :dispatch

  @bank_charge_response %{
    "amount" => 100.0,
    "authorization" => nil,
    "conciliated" => false,
    "creation_date" => "2019-05-21T21:36:17-05:00",
    "currency" => "MXN",
    "customer" => %{
      "address" => nil,
      "clabe" => nil,
      "creation_date" => "2019-05-21T21:36:17-05:00",
      "email" => "email@email.com",
      "external_id" => nil,
      "last_name" => nil,
      "name" => "Soy un cliente",
      "phone_number" => nil
    },
    "description" => "Cargo con banco",
    "due_date" => "2019-06-20T23:59:59-05:00",
    "error_message" => nil,
    "id" => "trv2souo8bvx6f00bffv",
    "method" => "bank_account",
    "operation_date" => "2019-05-21T21:36:17-05:00",
    "operation_type" => "in",
    "order_id" => "oid-000555",
    "payment_method" => %{
      "agreement" => "0000000",
      "bank" => "BBVA Bancomer",
      "clabe" => "000000000000000001",
      "name" => "11005248323220343213",
      "type" => "bank_transfer"
    },
    "status" => "in_progress",
    "transaction_type" => "charge"
  }

  @store_charge_response %{
    "id" => "trqbvetwiyqm5cntfqbf",
    "authorization" => nil,
    "operation_type" => "in",
    "method" => "store",
    "transaction_type" => "charge",
    "status" => "in_progress",
    "conciliated" => false,
    "creation_date" => "2019-05-21T21:36:17-05:00",
    "operation_date" => "2019-05-21T21:36:17-05:00",
    "description" => "Cargo a tienda",
    "error_message" => nil,
    "order_id" => "oid-00056",
    "payment_method" => %{
      "type" => "store",
      "reference" => "1010101722591752",
      "barcode_url" => "https://sandbox-api.openpay.mx/barcode/1010101722591752?width=1&height=45&text=false"
    },
    "amount" => 100.00,
    "customer" => %{
      "name" => "Soy un cliente",
      "last_name" => nil,
      "email" => "email@email.com",
      "phone_number" => nil,
      "address" => nil,
      "creation_date" => "2019-05-28T23:23:18-05:00",
      "external_id" => nil,
      "clabe" => nil
    },
    "currency" => "MXN"
  }

  post "/test_merchant_id/charges" do
    case _check_params(conn.params) do
      :charge_bank_account ->
        success(conn, @bank_charge_response)
      :charge_store ->
        success(conn, @store_charge_response)
      _params ->
        failure(conn)
    end
  end

  defp _check_params(%{"method" => "banck_account"}), do: :charge_bank_account

  defp _check_params(%{"method" => "store"}), do: :charge_store

  defp _check_params(_params), do: :failure

  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end

  defp success(conn, body \\ "") do
    conn
    |> Plug.Conn.send_resp(200, Jason.encode!(body))
  end

  defp failure(conn) do
    conn
    |> Plug.Conn.send_resp(422, Jason.encode!(%{message: "error message"}))
  end

end
