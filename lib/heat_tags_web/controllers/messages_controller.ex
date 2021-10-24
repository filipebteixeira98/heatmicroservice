defmodule HeatTagsWeb.MessagesController do
  use HeatTagsWeb, :controller

  def create(connection, params) do
    IO.inspect(params)

    connection
    |> text("Received POST request")
  end
end
