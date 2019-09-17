defmodule Conty do
  import Ecto.Query, warn: false

  alias Conty.{Account, Entry, EntryItem}

  def repo do
    Application.get_env(:conty, :ecto_repos) |> List.first
  end

  @moduledoc """
  Documentation for Conty.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Conty.hello()
      :world

  """
  def hello do
    :world
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> repo().insert
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
