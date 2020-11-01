defmodule C.CMS.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :age, :integer
    field :bio, :string
    field :name, :string
    field :public, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :age, :bio, :public])
    |> validate_required([:name, :age, :bio, :public])
  end
end
