defmodule ExCrowdin.Translation do
  @moduledoc """
  Work with Crowdin String translations

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/String-Translations
  """

  alias ExCrowdin.{API, Config}

  def list(string_id, language_id, query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query =
      %{"stringId" => string_id, "languageId" => language_id}
      |> Map.merge(query)
      |> URI.encode_query()

    path = API.project_path(project_id, "/translations?#{encoded_query}")
    API.request(path, :get)
  end

  def add(body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/translations")
    API.request(path, :post, body)
  end

  def delete(string_id, language_id, project_id \\ Config.project_id()) do
    query = %{"stringId" => string_id, "languageId" => language_id} |> URI.encode_query()
    path = API.project_path(project_id, "/translations?#{query}")
    API.request(path, :delete)
  end

  def list_pre_translations(query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = query |> URI.encode_query()
    path = API.project_path(project_id, "/pre-translations?#{encoded_query}")
    API.request(path, :get)
  end

  def list_pre_translations!(query \\ %{}, project_id \\ Config.project_id()) do
    case list_pre_translations(query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def list_language_translations(language_id, query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = query |> URI.encode_query()

    path = API.project_path(project_id, "/languages/#{language_id}/translations?#{encoded_query}")
    API.request(path, :get)
  end

  def list!(string_id, language_id, query \\ %{}, project_id \\ Config.project_id()) do
    case list(string_id, language_id, query, project_id) do
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

  def delete!(string_id, language_id, project_id \\ Config.project_id()) do
    case delete(string_id, language_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def list_language_translations!(language_id, query \\ %{}, project_id \\ Config.project_id()) do
    case list_language_translations(language_id, query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  @doc """
  Build project translation.
  """
  def build_project(body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/translations/builds")
    API.request(path, :post, body)
  end

  @doc """
  Check project build status.
  """
  def get_build_status(build_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/translations/builds/#{build_id}")
    API.request(path, :get)
  end

  @doc """
  Download project translations.
  """
  def download_build(build_id, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/translations/builds/#{build_id}/download")
    API.request(path, :get)
  end

  # Bang versions
  def build_project!(body, project_id \\ Config.project_id()) do
    case build_project(body, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def get_build_status!(build_id, project_id \\ Config.project_id()) do
    case get_build_status(build_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def download_build!(build_id, project_id \\ Config.project_id()) do
    case download_build(build_id, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  @doc """
  List project builds.
  """
  def list_builds(query \\ %{}, project_id \\ Config.project_id()) do
    encoded_query = URI.encode_query(query)
    path = API.project_path(project_id, "/translations/builds?#{encoded_query}")
    API.request(path, :get)
  end

  def list_builds!(query \\ %{}, project_id \\ Config.project_id()) do
    case list_builds(query, project_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def export_project(body, project_id \\ Config.project_id()) do
    path = API.project_path(project_id, "/translations/exports")
    API.request(path, :post, body)
  end
end
