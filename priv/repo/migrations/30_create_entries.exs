defmodule Conty.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add(:date, :date)
      add(:description, :string)

      add(:organization_id, references(:organizations))

      timestamps()
    end
  end
end
