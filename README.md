# ExCrowdin

Forked from https://github.com/thekirinlab/ex_crowdin to support PO files.

ExCrowdin supports many Crowdin API v2 features. To get started add this to your `config.exs`:

```elixir
config :ex_crowdin,
  project_id: "your_project_id",
  access_token: "your_access_token"
```

or use environment variables `CROWDIN_PROJECT_ID` and `CROWDIN_ACCESS_TOKEN`.

## Usage

```elixir
ExCrowdin.File.list!()
ExCrowdin.Storage.list!()
```

## Working with PO files

There is a `mix crowdin.pot_upload` task that uploads a POT file to Crowdin.

```elixir
mix crowdin.pot_upload priv/gettext/default.pot
```

There is a `mix crowdin.po_download` task that downloads a PO file from Crowdin.

```elixir
mix crowdin.po_download priv/gettext/pt/default.po --language=pt-BR
```

The idea is to combine this with the rest of your gettext workflow for example using an alias()  like this in your `mix.exs`:

```elixir
  defp aliases() do
    [
      gettext: [
        "gettext.extract",
        "crowdin.pot_upload priv/gettext/default.pot",
        "gettext.merge priv/gettext --locale de --no-fuzzy",
        "crowdin.po_download priv/gettext/de/LC_MESSAGES/default.po --language=de",
      ],
    ]
  end
```

So most of the translation flow can be handled via the Crowdin UI and changes can be merged both ways.


## Installation

Add `ex_crowdin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_crowdin, "~> 0.2.1"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/ex_crowdin](https://hexdocs.pm/ex_crowdin).

