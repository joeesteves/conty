defmodule Conty do
  import Ecto.Query, warn: false

  alias Conty.{Entry, EntryItem, Repo}

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

  def list_entries() do
    Entry
    |> Repo.all()
    |> Repo.preload(:entry_items)
  end

  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end
end
