defmodule ExCrowdin do
  alias ExCrowdin.{Downloader, Uploader}

  @doc """
  Get crowin file ID by name. If it doesn't exist, create a new one.

  ## Example

      {:ok, file_id} = ExCrowdin.get_file_id(%Job{}, :title)
  """
  @spec get_file_id(struct(), atom()) :: {:ok, binary()} | {:error, any()}
  def get_file_id(struct, field) when is_struct(struct) do
    Uploader.get_file_id(struct, field)
  end

  @spec get_file_id(binary(), binary(), binary()) :: {:ok, binary()} | {:error, any()}
  def get_file_id(remote_name, file_content \\ nil, title \\ nil, type \\ "gettext") do
    Uploader.get_file_id(remote_name, file_content, title, type)
  end

  @doc """
  Create a file on Crowdin with unique name

  ## Example

      {:ok, %{"data" => %{"id" => id}}} = ExCrowdin.create_crowdin_file(%Job{})
  """
  @spec create_crowdin_file(struct()) :: list({:ok, binary()} | {:error, any()})
  def create_crowdin_file(struct) when is_struct(struct) do
    Uploader.create_crowdin_file(struct)
  end

  @spec create_crowdin_file(binary(), binary(), binary()) :: {:ok, binary()} | {:error, any()}
  def create_crowdin_file(remote_name, file_content, title \\ nil, type \\ "gettext") do
    Uploader.create_crowdin_file(remote_name, file_content, title, type)
  end

  @doc """
  Upload a record to Crowdin

  ## Example

      job = Repo.one(Job, limit: 1)
      {ok, file_id} = ExCrowdin.get_file_id(%Job{}, :title)
      {:ok, string_id} <- ExCrowdin.upload_one(job, :title, file_id)
  """
  @spec upload_one(struct(), atom(), binary()) :: {:ok, binary()} | {:error, any()}
  def upload_one(struct, field, file_id) do
    Uploader.upload_one(struct, field, file_id)
  end

  @doc """
  Get all tronslations of a file on Crowdin for a language

  ## Example

      {:ok, %{"data" => %{"stringId" => string_id, "text" => text}}} = ExCrowdin.get_crowdin_translations("fr", title, 4576)
  """
  @spec get_crowdin_translations(binary(), atom(), binary(), integer()) ::
          {:ok, list()} | {:error, any()}
  def get_crowdin_translations(locale, field, file_id, page \\ 0) do
    Downloader.get_crowdin_translations(locale, field, file_id, page)
  end
end
