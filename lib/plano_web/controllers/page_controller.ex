defmodule PlanoWeb.PageController do
  use PlanoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
