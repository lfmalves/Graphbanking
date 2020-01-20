# Graphbanking

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Query Formats

## To query all accounts
query {
    account {
    id
    currentBalance
    transactions {
      id
      address
      amount
      insertedAt
    }
  }
}

## To transfer money between accounts
mutation {
    transferMoney(
      sender: "828d1393-6ede-4f13-b1dd-e4a5628b5576",
      address: "b543c766-7ed5-43d4-bf53-203c580d2d39",
      amount: 10
      )
    {id
    address
    amount
    insertedAt
    accountId}
  }

## To open an account
mutation {
  openAccount(balance: 100) {id}
}

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

