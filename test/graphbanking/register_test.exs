defmodule Graphbanking.RegistersTest do
  use Graphbanking.DataCase

  alias Graphbanking.Registers

  describe "accounts" do
    alias Graphbanking.Registers.Account

    @valid_attrs %{current_balance: 120.5, id: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{current_balance: 456.7, id: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{current_balance: nil, id: nil}

    def accounts_fixture(attrs \\ %{}) do
      {:ok, accounts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Registers.create_accounts()

      accounts
    end

    test "list_accounts/0 returns all accounts" do
      accounts = accounts_fixture()
      assert Registers.list_accounts() == [accounts]
    end

    test "get_accounts!/1 returns the accounts with given id" do
      accounts = accounts_fixture()
      assert Registers.get_accounts!(accounts.id) == accounts
    end

    test "create_accounts/1 with valid data creates a accounts" do
      assert {:ok, %Account{} = accounts} = Registers.create_accounts(@valid_attrs)
      assert accounts.current_balance == 120.5
      assert accounts.id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_accounts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registers.create_accounts(@invalid_attrs)
    end

    test "update_accounts/2 with valid data updates the accounts" do
      accounts = accounts_fixture()
      assert {:ok, %Account{} = accounts} = Registers.update_accounts(accounts, @update_attrs)
      assert accounts.current_balance == 456.7
      assert accounts.id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_accounts/2 with invalid data returns error changeset" do
      accounts = accounts_fixture()
      assert {:error, %Ecto.Changeset{}} = Registers.update_accounts(accounts, @invalid_attrs)
      assert accounts == Registers.get_accounts!(accounts.id)
    end

    test "delete_accounts/1 deletes the accounts" do
      accounts = accounts_fixture()
      assert {:ok, %Account{}} = Registers.delete_accounts(accounts)
      assert_raise Ecto.NoResultsError, fn -> Registers.get_accounts!(accounts.id) end
    end

    test "change_accounts/1 returns a accounts changeset" do
      accounts = accounts_fixture()
      assert %Ecto.Changeset{} = Registers.change_accounts(accounts)
    end
  end
end
