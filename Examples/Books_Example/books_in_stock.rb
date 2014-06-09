class BooksInStock
	attr_reader :price, :isbn

	def initialize(isbn, price)
		@isbn = isbn
		@price = price
	end
end
