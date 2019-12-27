defmodule Conty.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add(:type, :string)
      add(:terms, :string)

      add(:entry_id, references(:entries, on_delete: :delete_all))
    end

    create index(:transactions, [:entry_id])
  end
end
