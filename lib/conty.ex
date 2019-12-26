defmodule Conty do
  import Ecto.Query, warn: false

  alias Conty.{Account, Entry, EntryItem}

  def repo do
    Application.get_env(:conty, :ecto_repos) |> List.first
  end

  def list_accounts do
    Account
    |> repo.all()
  end

  def list_accounts() do
    Account
    |> repo().all()
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> repo.insert()
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
