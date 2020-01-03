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
      assert %{terms: terms} = result
      assert terms |> length == 1
      assert [%Term{} | _] = terms
    end

    test "generates 2 term" do
      transaction = %Transaction{
        due_base_date: ~D[2020-01-01],
        terms_generator: "c2"
      }

      result = Term.generate(transaction)
      assert %{terms: [%Term{percent: percent} | _]  = terms} = result
      assert terms |> length == 2
      assert Decimal.eq?(percent, Decimal.cast(50))
    end

    test "generates 3 term, round in last" do
      transaction = %Transaction{
        due_base_date: ~D[2020-01-01],
        terms_generator: "c3"
      }

      result = Term.generate(transaction)
      assert %{terms: [%Term{percent: percent}, _ , %{percent: percent2}]  = terms} = result
      assert terms |> length == 3
      assert Decimal.eq?(percent, Decimal.cast(33.33))
      assert Decimal.eq?(percent2, Decimal.cast(33.34))
    end
    # TODO: c0 should return {:error, :bad_argument}
    test "generates error" do
      transaction = %Transaction{
        due_base_date: ~D[2020-01-01],
        terms_generator: "c0"
      }

      result = Term.generate(transaction)
      assert %{terms: terms} = result
      assert terms |> length == 1
      assert [%Term{} | _] = terms
    end
  end
end
