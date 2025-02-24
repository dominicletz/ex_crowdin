defmodule ExCrowdin.Branch do
  @moduledoc """
  Work with Crowdin branches

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/Source-Files
  """

  alias ExCrowdin.{API, Config}

  def list(query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = URI.encode_query(query)
    path = API.project_path(project_id, "/branches?#{encoded_query}")
    API.request(path, :get)
  end

  def get(branch_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/branches/#{branch_id}")
    API.request(path, :get)
  end

  def add(body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/branches")
    API.request(path, :post, body)
  end

  def delete(branch_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/branches/#{branch_id}")
    API.request(path, :delete)
  end

  def edit(branch_id, patches, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/branches/#{branch_id}")
    API.request(path, :patch, patches)
  end

  def list!(query \\ %{}, project_id \\ Config.project_id()) do
    case list(query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def get!(branch_id, project_id \\ Config.project_id()) do
    case get(branch_id, project_id) do
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

  def delete!(branch_id, project_id \\ Config.project_id()) do
    case delete(branch_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def edit!(branch_id, patches, project_id \\ Config.project_id()) do
    case edit(branch_id, patches, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end
end
