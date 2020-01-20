defmodule GraphbankingWeb.AccountResolver do
  alias Graphbanking.Repo
  alias Graphbanking.Registers.Account

  def all(_args, _info) do
    accounts =
      Repo.all(Account)
      |> Repo.preload([:transactions])

    {:ok, accounts}
  end
end
