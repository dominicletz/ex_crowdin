defmodule Mix.Tasks.Crowdin.PoDownload do
  @moduledoc """
  For every language in available in translations builds and downloads the PO file.
  """

  use Mix.Task

  # Correct format is:
  #
  # mix crowdin.po_download path/to/po/file.po --language=pt-BR --remote-name="default.pot"
  def run(args) do
    OptionParser.parse(args, strict: [language: :string, remote_name: :string])
    |> case do
      {opts, [path | _], _} ->
        language = opts[:language] || "en"
        remote_name = opts[:remote_name] || "default.pot"
        download_po_file(path, language, remote_name)

      _other ->
        # Warn about missing arguments
        Mix.shell().error("Missing file argument: <path_to_po_file>")

        Mix.shell().error(
          "Usage: mix crowdin.po_download path/to/po/file.po --language=language --remote-name=name"
        )
    end
  end

  defp download_po_file(path, language, remote_name) do
    Application.ensure_all_started(:ex_crowdin)

    with {:ok, file_id} <- ExCrowdin.get_file_id(remote_name, nil, remote_name, "gettext"),
         {:ok, %{"data" => %{"url" => url}}} <-
           ExCrowdin.Translation.export_project(%{targetLanguageId: language, fileIds: [file_id]}),
         {:ok, %{status_code: 200, body: content}} <- HTTPoison.get(url),
         :ok <- File.write(path, content) do
      Mix.shell().info("Successfully downloaded translations to: #{path}")
      :ok
    else
      {:error, reason} ->
        Mix.shell().error("Error: #{inspect(reason)}")
    end
  end
end
