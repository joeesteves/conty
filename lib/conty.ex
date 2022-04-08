defmodule Conty do
  @moduledoc false

  import Ecto.Query, warn: false

  alias Conty.{Account, Entry, Organization}

  def repo do
    hd(Application.get_env(:conty, :ecto_repos))
  end

  def create_organization(attrs \\ %{}) do
    %Organization{}
    |> Organization.changeset(attrs)
    |> repo().insert()
  end

  def list_accounts() do
    Account
    |> repo().all()
  end

  def list_accounts_by_organization(organization_id) do
    from(a in Account, where: a.organization_id == ^organization_id)
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

  def debit_items(fact) do
    Enum.filter(fact.items, &(&1.side == :debit))
  end

  def credit_items(fact) do
    Enum.filter(fact.items, &(&1.side == :credit))
  end
end
