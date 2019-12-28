defmodule Conty.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add(:amount, :decimal)
      add(:type, :string)
      add(:terms, :string)

      add(:entry_id, references(:entries, on_delete: :delete_all))
      add(:account_due_id, references(:accounts))
      add(:account_pay_id, references(:accounts))
    end

    create(index(:transactions, [:entry_id]))
  end
end
