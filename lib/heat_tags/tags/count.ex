defmodule HeatTags.Tags.Count do
  alias HeatTags.Messages.Get

  def call do
    Get.today_messages()
    |> Task.async_stream(&count_words(&1.message))
    # |> Enum.to_list()
    |> Enum.reduce(%{}, fn element, accumulator -> sum_values(element, accumulator) end)
  end

  defp count_words(message) do
    message
    |> String.split()
    |> Enum.frequencies()
  end

  defp sum_values({:ok, map}, other_map) do
    Map.merge(map, other_map, fn _key, map_value, other_map_value ->
      map_value + other_map_value
    end)
  end
end
