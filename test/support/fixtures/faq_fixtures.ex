defmodule Pento.FaqFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Faq` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        name: "some name",
        answer: "some answer",
        vote_count: 42
      })
      |> Pento.Faq.create_question()

    question
  end
end
