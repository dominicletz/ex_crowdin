defmodule ExCrowdin.String do
  @moduledoc """
  Work with Crowdin source strings

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/Source-Strings
  """

  alias ExCrowdin.{API, Config}

  def list(query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = URI.encode_query(query)
    path = API.project_path(project_id, "/strings?#{encoded_query}")
    API.request(path, :get)
  end

  def add(body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/strings")
    API.request(path, :post, body)
  end

  def get(string_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/strings/#{string_id}")
    API.request(path, :get)
  end

  def delete(string_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/strings/#{string_id}")
    API.request(path, :delete)
  end

  def edit(string_id, patches, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/strings/#{string_id}")
    API.request(path, :patch, patches)
  end

  def list!(query \\ %{}, project_id \\ Config.project_id()) do
    case list(query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def add!(body, project_id \\ Config.project_id()) do
    case add(body, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def get!(string_id, project_id \\ Config.project_id()) do
    case get(string_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def delete!(string_id, project_id \\ Config.project_id()) do
    case delete(string_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def edit!(string_id, patches, project_id \\ Config.project_id()) do
    case edit(string_id, patches, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end
end
