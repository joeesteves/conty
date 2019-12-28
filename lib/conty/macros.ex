defmodule Conty.Transaction.Macros do
  defmacro fields do
    quote do
      field :type, :string
      field :terms, :string

      # TODO: MAYBE has_many through later to support groups
      belongs_to :entry, Conty.Entry
    end
  end
end
