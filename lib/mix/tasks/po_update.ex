defmodule Mix.Tasks.Crowdin.PoUpdate do
  @moduledoc """
  Update PO files with Crowdin
  """

  use Mix.Task

  @impl Mix.Task
  # Correct format is:
  #
  # mix ex_crowdin.po_update path/to/po/file.po --update-existing --remote-name=filename
  # update-existing is optional, it will update the existing file
  def run(args) do
    OptionParser.parse(args, strict: [create: :boolean, remote_name: :string])
    |> case do
      {opts, [path | _], _} ->
        update_po_file(path, opts)

      other ->
        # Warn about missing arguments
        IO.inspect(other)
        Mix.shell().error("Missing file argument: <path_to_po_file>")

        Mix.shell().error(
          "Usage: mix ex_crowdin.po_update path/to/po/file.po --create --remote-name=name"
        )
    end
  end

  defp update_po_file(path, opts) do
    Application.ensure_all_started(:ex_crowdin)
    remote_name = opts[:remote_name] || Path.basename(path)

    with {:ok, file_id} <- ExCrowdin.get_file_id(remote_name, nil, remote_name, "gettext"),
         {:ok, file_content} <- File.read(path),
         {:ok, %{"data" => %{"id" => storage_id}}} <-
           ExCrowdin.Storage.add(file_content, remote_name <> ".pot", "text/plain; charset=UTF-8") do
      ExCrowdin.File.update(file_id, %{
        "storageId" => storage_id,
        "name" => remote_name,
        "updateOption" => "keep_translations_and_approvals"
      })
    else
      {:error, :not_found} ->
        if opts[:create] do
          ExCrowdin.create_crowdin_file(remote_name, File.read!(path), remote_name, "gettext")
        else
          {:error, "File not found: #{remote_name}"}
        end

      error ->
        {:error, "Getting file ID: #{inspect(error)}"}
    end
    |> case do
      {:error, reason} ->
        Mix.shell().error("Error: #{inspect(reason)}")

      {:ok, _} ->
        Mix.shell().info("File updated: #{remote_name}")
    end
  end
end
