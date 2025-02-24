defmodule ExCrowdin.Language do
  @moduledoc """
  Work with Crowdin Languages

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/Languages
  """

  alias ExCrowdin.{API, Config}

  def list(query \\ %{}, _project_id \\ Config.project_id()) do
    encoded_query = query |> URI.encode_query()
    path = "/languages?#{encoded_query}"
    API.request(path, :get)
  end

  def list!(query \\ %{}, project_id \\ Config.project_id()) do
    case list(query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end
end
