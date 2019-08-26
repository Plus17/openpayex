defmodule Openpayex.ChargesTest do
  use ExUnit.Case

  alias Openpayex.Charges

  test "create bank charge for bank without create a client" do
    params = %{
      method: "banck_account",
      amount: 100,
      description: "Cargo con banco",
      order_id: "oid-000555",
      customer: %{
        name: "Soy un cliente",
        email: "email@email.com"
      }
    }

    assert {:ok, response} = Charges.create(params)

    assert Map.get(response, "order_id") == params.order_id
    assert Map.get(response, "status") == "in_progress"
  end

  test "create store charge for store without create a client" do
    params = %{
      method: "store",
      amount: 100,
      description: "Cargo a tienda",
      order_id: "oid-00056",
      customer: %{
        name: "Soy un cliente",
        email: "email@email.com"
      }
    }

    assert {:ok, response} = Charges.create(params)

    assert Map.get(response, "order_id") == params.order_id
    assert Map.get(response, "status") == "in_progress"
    assert get_in(response, ["payment_method", "type"]) == "store"
  end

  test "create charge with incomplete params return an error" do
    incomplete_params = %{
      amount: 100,
      description: "Cargo a tienda",
      order_id: "oid-00056",
      customer: %{
        name: "Soy un cliente",
        email: "email@email.com"
      }
    }

    assert {:error, :bad_params} == Charges.create(incomplete_params)
  end
end
