defmodule CookBook.Router do
  use CookBook.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CookBook do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create]
    get "/recipes", RecipeController, :index
    get "/recipes/:id/edit", RecipeController, :edit
    get "/recipes/new", RecipeController, :new
    get "/recipes/:id", RecipeController, :show
    post "/recipes", RecipeController, :create
    put "/recipes/:id", RecipeController, :update
    delete "/recipes/:id", RecipeController, :delete
    resources "/users", UserController
    resources "/categories", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookBook do
  #   pipe_through :api
  # end
end
