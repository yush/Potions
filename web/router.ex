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
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/categories", CategoryController
    resources "/users", UserController do
      resources "/recipes", RecipeController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookBook do
  #   pipe_through :api
  # end
end
