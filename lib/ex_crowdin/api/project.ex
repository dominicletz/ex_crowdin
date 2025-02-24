defmodule ExCrowdin.Project do
  @moduledoc """
  Work with Crowdin Projects

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/Projects
  """
  alias ExCrowdin.{API, Config}

  def list(query \\ %{}) do
    encoded_query = query |> URI.encode_query()
    API.request("/projects?#{encoded_query}", :get)
  end

  def list!(query \\ %{}) do
    case list(query) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def get(project_id \\ Config.project_id()) do
    API.request("/projects/#{project_id}", :get)
  end

  def get!(project_id \\ Config.project_id()) do
    case get(project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end
end
