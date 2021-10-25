defmodule HeatTagsWeb.MessagesController do
  use HeatTagsWeb, :controller

  alias HeatTags.Message
  alias HeatTags.Messages.Create

  def create(connection, params) do
    params
    |> Create.call()
    |> handle_create(connection)
  end

  defp handle_create({:ok, %Message{} = message}, connection) do
    connection
    |> put_status(:created)
    |> render("create.json", message: message)
  end

  defp handle_create({:error, %{result: result, status: status}}, connection) do
    connection
    |> put_status(status)
    |> put_view(HeatTagsWeb.ErrorView)
    |> render("error.json", result: result)
  end
end
