defmodule ServebcgameWeb.RoomChannel do
  use Phoenix.Channel
  alias ServebcgameWeb.Presence

  def join("room:lobby", %{"name" => name}, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, :name, name)}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} =
      Presence.track(socket, socket.assigns.name, %{
        online_at: inspect(System.system_time(:second))
      })

    push(socket, "presence_state", Presence.list(socket))
    broadcast!(socket, "new_msg", %{body: socket.assigns.name <> " joined"})
    {:noreply, socket}
  end

  # intercept ["user_joined"]
  #
  # def handle_out("user_joined", msg, socket) do
  #   if Accounts.ignoring_user?(socket.assigns[:user], msg.user_id) do
  #     {:noreply, socket}
  #   else
  #     push(socket, "user_joined", msg)
  #     {:noreply, socket}
  #   end
  # end
end
