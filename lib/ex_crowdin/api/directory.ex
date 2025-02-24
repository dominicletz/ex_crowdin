defmodule ExCrowdin.Directory do
  @moduledoc """
  Work with Crowdin directories

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/Source-Files
  """

  alias ExCrowdin.{API, Config}

  def list(query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = URI.encode_query(query)
    path = API.project_path(project_id, "/directories?#{encoded_query}")
    API.request(path, :get)
  end

  def get(directory_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/directories/#{directory_id}")
    API.request(path, :get)
  end

  def add(body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/directories")
    API.request(path, :post, body)
  end

  def delete(directory_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/directories/#{directory_id}")
    API.request(path, :delete)
  end

  def edit(directory_id, patches, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/directories/#{directory_id}")
    API.request(path, :patch, patches)
  end

  def list!(query \\ %{}, project_id \\ Config.project_id()) do
    case list(query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def get!(directory_id, project_id \\ Config.project_id()) do
    case get(directory_id, project_id) do
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

  def delete!(directory_id, project_id \\ Config.project_id()) do
    case delete(directory_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def edit!(directory_id, patches, project_id \\ Config.project_id()) do
    case edit(directory_id, patches, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end
end
