defmodule TermTest do
  use Conty.DataCase
  alias Conty.{Transaction, Term}

  describe "tests" do
    test "generates 1 term" do
      transaction = %Transaction{
        due_base_date: ~D[2020-01-01],
        terms_generator: "0"
      }

      result = Term.generate(transaction)
      assert result |> length == 1
      assert [%Term{} | _] = result
    end

    test "generates 2 term" do
      transaction = %Transaction{
        due_base_date: ~D[2020-01-01],
        terms_generator: "c2"
      }

      [term | _] = result = Term.generate(transaction)
      assert result |> length == 2
      assert Decimal.eq?(term.percent, Decimal.cast(50))
    end

    test "generates 3 term, round in last" do
      transaction = %Transaction{
        due_base_date: ~D[2020-01-01],
        terms_generator: "c3"
      }

      [term1, term2, term3] = result = Term.generate(transaction)
      assert Decimal.eq?(term1.percent, Decimal.cast(33.33))
      assert Decimal.eq?(term3.percent, Decimal.cast(33.34))
    end

    # TODO: c0 should return {:error, :bad_argument}
    test "generates error" do
      transaction =
        Transaction.changeset(
          %Transaction{},
          %{
            due_base_date: ~D[2020-01-01],
            terms_generator: "c0"
          }
        )

      assert !transaction.valid?
      ["has invalid format" | _] = Tuple.to_list(transaction.errors[:terms_generator])
    end
  end
end
