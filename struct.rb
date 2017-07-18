# This is a great way to create lightweight stubs of ActiveRecord models.
# TransactionStub will have attributes id, symbol and user_id and #symbol.
# Note that symbol is cached and is not created every time.

SymbolStub = Struct.new(:symbol) do
  def canonical_symbol_name
    forex? ? symbol[0..5] : symbol
  end
end

TransactionStub = Struct.new(:id, :symbol, :user_id) do
  def symbol
    @symbol ||= SymbolStub.new(symbol)
  end
end
