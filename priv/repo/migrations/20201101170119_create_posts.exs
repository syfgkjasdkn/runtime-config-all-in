defmodule C.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :age, :integer
      add :bio, :text
      add :public, :boolean, default: false, null: false

      timestamps()
    end

  end
end
