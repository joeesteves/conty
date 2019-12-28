defmodule Conty.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add(:name, :string)
      add(:type, :integer)

      timestamps()
    end

    create index(:accounts, [:name])
  end
end
