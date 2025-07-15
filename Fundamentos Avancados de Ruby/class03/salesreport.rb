class SalesReport
    include Enumerable

    def initialize(sales)
        @sales = sales.map do |sale|
        sale[:amount] = sale[:amount].to_f  # Converter o valor de "amount" para float
        sale
        end
    end

    # Implementação do método each para o Enumerable
    def each(&block)
        @sales.each(&block)
    end

    # Total de vendas por categoria
    def total_by_category
        @sales.each_with_object(Hash.new(0)) do |sale, totals|
        totals[sale[:category]] += sale[:amount]
        end
    end

    # Retorna os n maiores valores de venda
    def top_sales(n)
        @sales.sort_by { |sale| -sale[:amount] }.first(n)
    end

    # Agrupa os produtos por categoria
    def grouped_by_category
        @sales.each_with_object(Hash.new { |hash, key| hash[key] = [] }) do |sale, grouped|
        grouped[sale[:category]] << sale[:product]
        end
    end

    # Vendas acima da média geral
    def above_average_sales
        total_sales = @sales.sum { |sale| sale[:amount] }
        average = total_sales / @sales.size
        @sales.select { |sale| sale[:amount] > average }
    end
end

sales = [
  { product: "Notebook", category: "Eletrônicos", amount: "3000" },
  { product: "Celular", category: "Eletrônicos", amount: "1500" },
  { product: "Cadeira", category: "Móveis", amount: "500" },
  { product: "Mesa", category: "Móveis", amount: "1200" },
  { product: "Headphone", category: "Eletrônicos", amount: "300" },
  { product: "Armário", category: "Móveis", amount: "800" }
]

report = SalesReport.new(sales)

puts "Total por categoria:"
puts report.total_by_category

puts "\nTop 3 maiores vendas:"
puts report.top_sales(3)

puts "\nProdutos agrupados por categoria:"
puts report.grouped_by_category

puts "\nVendas acima da média:"
puts report.above_average_sales
