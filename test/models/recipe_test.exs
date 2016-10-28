defmodule CookBook.RecipeTest do
  use CookBook.ModelCase

  alias CookBook.Recipe

  @valid_attrs %{file: "some content", name: "some content", uploadDate: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
