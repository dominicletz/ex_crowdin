defmodule ExCrowdin.Storage do
  @moduledoc """
  Work with Crowdin storage

  Crowdin API reference: https://support.crowdin.com/api/v2/#tag/Storage
  """

  alias ExCrowdin.API

  def list do
    API.request("/storages", :get)
  end

  def add(body, filename, content_type \\ "application/octet-stream") do
    API.request(
      "/storages",
      :post,
      body,
      %{
        "Crowdin-API-FileName": filename,
        "Content-Type": content_type
      }
    )
  end

  def get(storage_id) do
    API.request("/storages/#{storage_id}", :get)
  end

  def delete(storage_id) do
    API.request("/storages/#{storage_id}", :delete)
  end

  def list!() do
    case list() do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def add!(body, filename, content_type \\ "application/octet-stream") do
    case add(body, filename, content_type) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def get!(storage_id) do
    case get(storage_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end

  def delete!(storage_id) do
    case delete(storage_id) do
      {:ok, result} -> result
      {:error, error} -> raise error
    end
  end
end
