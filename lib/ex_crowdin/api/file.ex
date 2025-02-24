defmodule ExCrowdin.File do
  @moduledoc """
  Work with Crowdin source strings

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/Source-Strings
  """

  alias ExCrowdin.{API, Config}

  def list(query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = URI.encode_query(query)
    path = API.project_path(project_id, "/files?#{encoded_query}")
    API.request(path, :get)
  end

  def add(body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/files")
    API.request(path, :post, body)
  end

  def get(file_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/files/#{file_id}")
    API.request(path, :get)
  end

  def update(file_id, body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/files/#{file_id}")
    API.request(path, :put, body)
  end

  def delete(file_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/files/#{file_id}")
    API.request(path, :delete)
  end

  def edit(file_id, patches, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/files/#{file_id}")
    API.request(path, :patch, patches)
  end

  def download(file_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/files/#{file_id}/download")
    API.request(path, :get)
  end

  def preview(file_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/files/#{file_id}/preview")
    API.request(path, :get)
  end

  def list_progress(file_id, query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = URI.encode_query(query)
    path = API.project_path(project_id, "/files/#{file_id}/languages/progress?#{encoded_query}")
    API.request(path, :get)
  end

  def list_progress!(file_id, query \\ %{}, project_id \\ Config.project_id()) do
    case list_progress(file_id, query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
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

  def get!(file_id, project_id \\ Config.project_id()) do
    case get(file_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def update!(file_id, body, project_id \\ Config.project_id()) do
    case update(file_id, body, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def delete!(file_id, project_id \\ Config.project_id()) do
    case delete(file_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def edit!(file_id, patches, project_id \\ Config.project_id()) do
    case edit(file_id, patches, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def download!(file_id, project_id \\ Config.project_id()) do
    case download(file_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def preview!(file_id, project_id \\ Config.project_id()) do
    case preview(file_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end
end
