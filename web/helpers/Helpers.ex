defmodule CookBook.Helpers do

  def recipe_url(struct, type) do
    CookBook.Image.url({struct.file, struct}, type)
    |> Path.relative_to("priv/static")
  end

end

