ExUnit.start()

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
