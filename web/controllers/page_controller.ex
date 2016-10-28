defmodule CookBook.PageController do
  use CookBook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
