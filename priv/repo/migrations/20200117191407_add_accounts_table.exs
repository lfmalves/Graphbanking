defmodule Graphbanking.Repo.Migrations.AddAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :current_balance, :float

      timestamps()
    end
  end
end
