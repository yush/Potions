defmodule CookBook.RecipeController do
  use CookBook.Web, :controller

  alias CookBook.Recipe

  plug :assign_user
  plug :authorize_user when action in [:new, :create, :update, :edit, :delete]

  def index(conn, _params) do
    recipes = Repo.all(assoc(conn.assigns[:user], :recipes))
    render(conn, "index.html", recipes: recipes)
  end

  def new(conn, _params) do
    changeset = 
      conn.assigns[:user]
      |> build_assoc(:recipes)
      |> Recipe.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    IO.inspect recipe_params
    changeset = 
      conn.assigns[:user]
      |> build_assoc(:recipes)
      |> Recipe.changeset(recipe_params)

    case Repo.insert(changeset) do
      {:ok, _recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: user_recipe_path(conn, :index, conn.assigns[:user]))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Repo.get!(assoc(conn.assigns[:user], :recipes), id)
    render(conn, "show.html", recipe: recipe)
  end

  def edit(conn, %{"id" => id}) do
    recipe = Repo.get!(assoc(conn.assigns[:user], :recipes), id)
    changeset = Recipe.changeset(recipe)
    render(conn, "edit.html", recipe: recipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Repo.get!(assoc(conn.assigns[:user], :recipes), id)
    changeset = Recipe.changeset(recipe, recipe_params)

    case Repo.update(changeset) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe updated successfully.")
        |> redirect(to: user_recipe_path(conn, :show, conn.assigns[:user], recipe))
      {:error, changeset} ->
        render(conn, "edit.html", recipe: recipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Repo.get!(Recipe, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    recipe = Repo.get!(Recipe, id)

    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: user_recipe_path(conn, :index, conn.assigns[:user]))
  end

  defp assign_user(conn, _opts) do
    case conn.params do
      %{"user_id" => user_id} ->
      case Repo.get(CookBook.User, user_id) do
        nil -> invalid_user(conn)
        user -> assign(conn, :user, user)
      end
      _ -> invalid_user(conn)
    end
  end

  defp invalid_user(conn) do
    conn
    |> put_flash(:error, "Invalid user!")
    |> redirect(to: page_path(conn, :index))
    |> halt
  end

  def authorize_user(conn, _opts) do
    user = get_session(conn, :current_user)
    if user && Integer.to_string(user.id) == conn.params["user_id"] do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to modify that post!")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end

end
