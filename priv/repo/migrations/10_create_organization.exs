defmodule Conty.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add(:name, :string)

      timestamps()
    end

    create(index(:organizations, [:name]))
  end
end
