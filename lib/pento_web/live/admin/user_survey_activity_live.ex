defmodule PentoWeb.Live.Admin.UserSurveyActivityLive do
  use PentoWeb, :live_component
  alias PentoWeb.Presence
  # coming soon!
  def update(_assigns, socket) do
    {:ok,
     socket
     |> assign_user_activity()}
  end

  def assign_user_activity(socket) do
    assign(socket, :user_survey_activity, Presence.list_surveys_user())
  end
end
