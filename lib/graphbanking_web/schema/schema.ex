defmodule GraphbankingWeb.Schema do
  use Absinthe.Schema
  alias Graphbanking.Registers.Transaction

  import_types(GraphbankingWeb.Schema.DataTypes)

  query do
    @desc "Get a list of accounts"
    field :account, list_of(:account) do
      resolve(&GraphbankingWeb.AccountResolver.all/2)
    end
  end

  mutation do
    @desc "Create a account"
    field :open_account, type: :account do
      arg(:balance, non_null(:float))

      resolve(fn %{balance: balance}, _context ->
        account =
          Graphbanking.Repo.insert!(%Graphbanking.Registers.Account{
            current_balance: balance
          })

        {:ok, account}
      end)
    end

    @desc "Transactions amounts between accounts"
    field :transfer_money, type: :transaction do
      arg(:sender, non_null(:string))
      arg(:address, non_null(:string))
      arg(:amount, non_null(:float))

      resolve(fn %{sender: account_id, address: address, amount: amount}, _context ->
        if Transaction.valid_amount(amount) &&
             Transaction.efective_transfer(account_id, address, amount) do
          transfer =
            Graphbanking.Repo.insert!(%Transaction{
              address: address,
              amount: amount,
              account_id: account_id
            })

          {:ok, transfer}
        else
          {:error, :transaction_error}
        end
      end)
    end
  end
end
