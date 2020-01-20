defmodule Graphbanking.Registers.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :current_balance, :float

    has_many(:transactions, Graphbanking.Registers.Transaction)

    timestamps()
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, [:id, :current_balance])
    |> validate_required([:id, :current_balance])
  end
end
