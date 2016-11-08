defmodule CookBook.SessionController do
  use CookBook.Web, :controller
  alias CookBook.User
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render(conn, "new.html", changeset: User.changeset(%User{user: "Jon"}))
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password }})
    when not is_nil username do 
    Repo.get_by(User, user: username)
    |> sign_in(password, conn)
  end

  def create(conn, _) do
    failed_login(conn)
  end


  defp sign_in(user, password, conn) when is_nil(user) do
    failed_login(conn)
  end

  defp sign_in(user, password, conn) do
    if checkpw(password, user.password_digest) do
      conn
      |> put_session(:current_user, %{id: user.id, user: user.user})
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: user_recipe_path(conn, :index, user))
    else
      failed_login(conn)
    end
  end

  defp failed_login(conn) do
    dummy_checkpw()
    conn
    |> put_session(:current_user, nil)
    |> put_flash(:error, "Invalid username/password combination!")
    |> redirect(to: page_path(conn, :index))
    |> halt()
  end

  def delete(conn, _params) do
      conn
      |> delete_session(:current_user)
      |> put_flash(:info, "Signed out successfully!")
      |> redirect(to: page_path(conn, :index))
  end

end
