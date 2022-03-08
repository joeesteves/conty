ExUnit.start()
# We need to manually start the repo since Conty is not an application but a bare Lib
Supervisor.start_link([Conty.Repo], [strategy: :one_for_one, name: Conty.Supervisor])

defmodule TestHelper do
  # https://github.com/phoenixframework/phoenix/blob/master/installer/templates/phx_ecto/data_case.ex
  # cherrypicked from pheonix datacase
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
