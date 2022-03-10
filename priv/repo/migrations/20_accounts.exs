defmodule Conty.Repo.Migrations.Accounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add(:name, :string)
      add(:organization_id, references(:organizations))

      timestamps()
    end

    create index(:accounts, [:name])
  end
end
