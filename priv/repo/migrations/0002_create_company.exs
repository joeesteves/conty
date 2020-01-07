defmodule Conty.Repo.Migrations.CreateCompany do
  use Ecto.Migration

  def change do
    create table(:companies) do
      # add(:organization_id, references(:organizations))

      add(:name, :string)
    end
  end
end
