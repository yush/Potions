defmodule CookBook.UserTest do
  use CookBook.ModelCase

  alias CookBook.User

  @valid_attrs %{email: "some content", password_digest: "some content", user: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
