defmodule Conty do
  @moduledoc false
  import Ecto.Query, warn: false

  alias Conty.{Account, Entry}

  def repo do
    Application.get_env(:conty, :ecto_repos)
    |> List.first()
  end

  def list_accounts() do
    Account
    |> repo().all()
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> repo().insert()
  end

  def delete_account(%Account{} = account) do
    account
    |> Account.changeset(%{})
    |> Ecto.Changeset.no_assoc_constraint(:entry_items)
    |> (fn account -> repo().delete(account) end).()
  end

  def list_entries() do
    Entry
    |> repo().all()
    |> repo().preload(:entry_items)
  end

  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> repo().insert()
  end
end
