defmodule Conty.Repo.Migrations.CreateTerms do
  use Ecto.Migration

  def change do
    create table(:terms) do
      add(:date, :date)
      add(:percent, :decimal)

      add(:transaction_id, references(:transactions, on_delete: :delete_all))
    end

    create index(:terms, [:transaction_id])
  end
end
