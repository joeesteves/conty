defmodule Conty.Term do
  use Ecto.Schema
  import Ecto.Changeset
  import Date, only: [add: 2]
  alias Decimal, as: D
  alias Conty.Term

  embedded_schema do
    field(:date, :date)
    field(:percent, :decimal)
    field(:amount, :decimal)

    field(:account_id, :integer)
    field(:company_id, :integer)
  end

  def changeset(%Term{} = term, attrs) do
    term
    |> cast(attrs, [:date, :percent])
    |> validate_required([:date, :percent])
  end

  def generatorFormat do
    ~r/^((((\d{1,3}:\d{1,2}(,\s?)?)){1,5}|((\d{1,3}(,\s?)?)){1,5})|[C,c]\d{1,2})$/
  end

  def generate(transaction, sign) do
    D.set_context(%D.Context{D.get_context() | precision: 8})

    terms_generator = transaction.terms_generator

    terms_generator_splited =
      cond do
        Regex.match?(~r/^[C,c]\d{1,2}$/, terms_generator) ->
          %{"installments" => installments} =
            Regex.named_captures(~r/[C,c](?<installments>\d{1,2})/, terms_generator)

          installments = String.to_integer(installments)
          1..installments |> Enum.map(&Integer.to_string((&1 - 1) * 31))

        true ->
          String.split(terms_generator, ~r/,\s?/)
      end

    terms_generator_splited
    |> Enum.map(fn term ->
      String.split(term, ~r/\:/) |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(&[length(terms_generator_splited) | &1])
    |> Enum.with_index()
    |> Enum.map(fn {data, idx} ->
      parsePercent(transaction, Enum.zip([:length, :days, :percent], data), idx, sign)
    end)
  end

  defp parsePercent(transaction, [length: _, days: days, percent: percent], _, _) do
    %Term{date: transaction.due_base_date |> add(days), percent: D.new(percent)}
  end

  defp parsePercent(transaction, [length: length, days: days], idx, sign) do
    percent = calculatePercent(length, idx)

    %Term{
      date: transaction.due_base_date |> add(days),
      percent: percent,
      amount: Decimal.mult(percent, transaction.amount) |> Decimal.div(sign * 100),
      account_id: transaction.account_due_id,
      company_id: transaction.company_id
    }
  end

  defp calculatePercent(length, idx) do
    installment = D.new(100) |> D.div(D.new(length))
    lap = idx + 1

    percent =
      cond do
        length == lap ->
          # D.set_context(%D.Context{D.get_context() | precision: 4})
          installment |> D.mult(D.new(idx)) |> D.minus() |> D.add(D.new(100))

        true ->
          installment
      end

    # D.set_context(%D.Context{D.get_context() | precision: 4})
    percent
  end
end
