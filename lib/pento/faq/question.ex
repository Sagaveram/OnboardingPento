defmodule Pento.Faq.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :name, :string
    # embeds_many {:array, :string}, default: []
    field :answer, :string
    field :vote_count, :integer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:name, :vote_count])
    |> validate_required([:name, :vote_count])
  end
end
