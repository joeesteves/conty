defmodule Conty.Repo.Migrations.CreateEntryItems do
  use Ecto.Migration

  def change do
    create table(:entry_items) do
      add(:amount, :decimal)
      add(:due_date, :date)

      add(:side, :string)

      add(:entry_id, references(:entries, on_delete: :delete_all))
      add(:account_id, references(:accounts))
      add(:source_id, references(:accounts))
    end

    create(index(:entry_items, [:entry_id]))
  end
end
