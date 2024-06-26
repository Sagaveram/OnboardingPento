defmodule PentoWeb.QuestionLive.Index do
  use PentoWeb, :live_view

  alias Pento.Faq
  alias Pento.Faq.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :questions, list_questions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Question")
    |> assign(:question, Faq.get_question!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Question")
    |> assign(:question, %Question{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Questions")
    |> assign(:question, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    question = Faq.get_question!(id)
    {:ok, _} = Faq.delete_question(question)

    {:noreply, assign(socket, :questions, list_questions())}
  end

  defp list_questions do
    Faq.list_questions()
  end
end
