defmodule Mix.Tasks.Conty.Install do
  use Mix.Task

  @shortdoc "Creates migrations needed by Conty on host proyect"

  @moduledoc """
    After adding conty as dep, run this command to create the SQL structure.
      conty install
  """

  @impl Mix.Task
  def run(_) do
    if(in_host?()) do
      migration_path = "priv/repo/migrations/"
      conty_migration_path = Path.join(Application.app_dir(:conty), migration_path)
      host_migration_path = Path.join(File.cwd!(), migration_path)

      clean(host_migration_path)

      conty_migration_path
      |> File.ls!()
      |> Enum.each(fn migration_filename ->
        target_path = Path.join(host_migration_path, restamp(migration_filename))

        File.cp(
          Path.join(conty_migration_path, migration_filename),
          target_path
        )

        File.read!(target_path)
        |> String.replace(~r/Conty/, host_name())
        |> (&File.write!(target_path, &1)).()
      end)
    else
      IO.puts("☠ ️Danger ☠ You are at Conty, not on host")
    end
  end

  defp in_host? do
    Application.app_dir(:conty) != Mix.Project.app_path()
  end

  def host_name do
    Mix.Project.get().project[:app] |> Atom.to_string() |> String.capitalize()
  end

  defp clean(dir) do
    File.ls!(dir)
    |> Enum.filter(&Regex.match?(~r/_conty_/, &1))
    |> Enum.each(fn filename -> File.rm!(Path.join(dir, filename)) end)
  end

  defp restamp(filename) do
    String.replace(filename, ~r/\d+_/, ~s(#{timestamp()}_conty_))
  end

  defp timestamp do
    :timer.sleep(1000)
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()

    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: <<?0, ?0 + i>>
  defp pad(i), do: to_string(i)
end
