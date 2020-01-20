defmodule Graphbanking.Repo.Migrations.AddTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :account_id, references("accounts", type: :binary_id)
      add :id, :uuid, primary_key: true
      add :address, :string
      add :amount, :float

      timestamps()
    end
  end
end
