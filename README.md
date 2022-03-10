[![Elixir CI](https://github.com/ponyesteves/conty/actions/workflows/elixir.yml/badge.svg)](https://github.com/ponyesteves/conty/actions/workflows/elixir.yml)

# Conty

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `conty` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:conty, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/conty](https://hexdocs.pm/conty).

`mix conty install to migrations`
# Config

### To enable and validate organization_id on accounts and entry you should add to your `config/config.exs`

```elixir
  config :conty, use_organization: true
```

