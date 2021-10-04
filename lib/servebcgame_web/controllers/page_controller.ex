defmodule ServebcgameWeb.PageController do
  use ServebcgameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
