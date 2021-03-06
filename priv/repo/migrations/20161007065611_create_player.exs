defmodule PhoenixPoker.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :nickname, :string
      add :email, :string

      timestamps()
    end

  end
end
