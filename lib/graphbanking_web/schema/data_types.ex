defmodule GraphbankingWeb.Schema.DataTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Graphbanking.Repo

  import_types(Absinthe.Type.Custom)

  object :account do
    field :id, :id
    field :current_balance, :float
    field :transactions, list_of(:transaction)
  end

  object :transaction do
    field :id, :id
    field :address, :string
    field :amount, :float
    field :inserted_at, :naive_datetime
    field :account_id, :string
  end
end
