defmodule Conty do
  import Ecto.Query, warn: false
  alias Conty.{Account, Entry, EntryItem}

  def repo do
    Application.get_env(:conty, :ecto_repos) |> List.first()
  end

  def list_accounts() do
    Account
    |> repo().all()
  end

  def list_accounts_by_type(type_keys) do
    query =
      from(a in Account,
        where: a.type in ^Enum.map(type_keys, &(Account.type_by_key(&1)))
      )

    repo().all(query)
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> repo().insert()
  end

  def list_entries() do
    Entry
    |> repo().all()
    |> repo().preload(:items)
  end

  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> repo().insert()
  end

  def company_due(company_id) do
    query = from(ei in EntryItem,
    where: ei.company_id == ^company_id)

    repo().all(query)
    |> Enum.reduce(Decimal.cast(0), fn x,acc ->
      Decimal.add(x.amount, acc)
    end)
  end
end
