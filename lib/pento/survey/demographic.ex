defmodule Pento.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "demographics" do
    field :gender, :string
    field :education_level, :string
    field :year_of_birth, :integer
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, [:gender, :year_of_birth, :user_id, :education_level])
    |> validate_required([:gender, :year_of_birth, :user_id, :education_level])
    |> validate_inclusion(
      :gender,
      ["male", "female", "other", "prefer not to say"]
    )
    |> validate_inclusion(:year_of_birth, 1900..2022)
    |> unique_constraint(:user_id)
  end
end
