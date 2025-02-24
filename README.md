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

There is a `mix crowdin.po_update` task that updates a PO file in Crowdin.

```elixir
mix crowdin.po_update priv/gettext/default.po --create
```

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

