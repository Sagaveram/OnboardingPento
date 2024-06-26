defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess:",
       rand_num: Enum.random(1..10),
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %> It's <%= time() %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    <button phx-click="restart">Jugar de nuevo</button>
    <h2>
      <pre>
      <%= @session_id %>
    </pre>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  # def handle_event("guess", %{"number" => guess} = data, socket) do
  #   message = "Your guess: #{guess}. Wrong. Guess again. "
  #   score = socket.assigns.score - 1
  #   rand_nume= socket.assigns.rand_num

  #   {
  #     :noreply,
  #     assign(
  #       socket,
  #       message: message,
  #       score: score,
  #       rand_num: rand_nume
  #     )
  #   }
  # end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    {num, ""} = Integer.parse(guess)

    if socket.assigns.rand_num == num do
      message = "Your guess was right"
      score = socket.assigns.score + 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          rand_num: socket.assigns.rand_num
        )
      }
    else
      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          rand_num: socket.assigns.rand_num
        )
      }
    end
  end

  # Reinicia el juego cuando se toca el boton de restart, es posible ya que el botón tiene phx-click = "restart"
  def handle_event("restart", _params, socket) do
    nuevo_rand_num = Enum.random(1..10)
    {:noreply, assign(socket, rand_num: nuevo_rand_num, message: "Adivina:", score: 0)}
  end
end
