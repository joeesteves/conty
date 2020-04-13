# Conty

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `conty` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:conty, "~> 0.2.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/conty](https://hexdocs.pm/conty).

### Copy migrations
  `$> mix conty install`

### Configuration

in your config.exs file

config :conty, :options,
  organization_module: 'Organization module related to transactions and entries, if module is passed here you must uncomment organization_id lines on migrations before running them'

# conty
