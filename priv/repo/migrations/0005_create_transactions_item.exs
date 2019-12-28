defmodule Conty.Repo.Migrations.CreateTransactionItems do
  use Ecto.Migration

  def change do
    create table(:transaction_items) do
      add(:amount, :decimal)
      add(:description, :string)

      add(:account_id, references(:accounts))
      add(:transaction_id, references(:transactions, on_delete: :delete_all))
    end

    create index(:transaction_items, [:transaction_id])
  end
end
