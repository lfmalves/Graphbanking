defmodule Graphbanking.Registers.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias Graphbanking.Registers.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transactions" do
    field :address, :string
    field :amount, :float

    belongs_to(:account, Graphbanking.Registers.Account)

    timestamps()
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, [:id, :address, :amount, :account_id])
    |> validate_required([:id, :address, :amount])
  end

  def valid_amount(amount) do
    if amount > 0 do
      {:ok, amount}
    else
      {:error, :invalid_amount}
    end
  end

  def efective_transfer(sender, receiver, amount) do
    sender = Graphbanking.Repo.get_by!(Account, id: sender)
    receiver = Graphbanking.Repo.get_by!(Account, id: receiver)
    amount_sender = sender.current_balance
    amount_receiver = receiver.current_balance

    if amount_sender - amount >= 0 do
      new_amount_sender = Ecto.Changeset.change(sender, current_balance: amount_sender - amount)

      new_amount_receiver =
        Ecto.Changeset.change(receiver, current_balance: amount_receiver + amount)

      case Graphbanking.Repo.update(new_amount_sender) &&
             Graphbanking.Repo.update(new_amount_receiver) do
        {:ok, _struct} -> :ok
        {:error, _changeset} -> "There was a problem with your transaction!"
      end
    end
  end
end
