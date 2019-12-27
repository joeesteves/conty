defmodule Conty do
  import Ecto.Query, warn: false

  alias Conty.{Account, Entry}

  def repo do
    Application.get_env(:conty, :ecto_repos) |> List.first()
  end

  def list_accounts() do
    Account
    |> repo().all()
  end

  def list_accounts_by_type(type_key) do
    query =
      from(a in Account,
        where: a.type == ^Account.type_by_key(type_key)
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
    |> repo.all()
    |> repo.preload(:entry_items)
  end

  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> repo.insert()
  end
end
