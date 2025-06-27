#yield (intermediate/advanced examples)

def math(a, b)
    puts "Beginning"
    yield(a, b)
end

math(2, 4) { |x, y| puts "Sum: #{x + y}" }
# math(3, 5) do |x, y|
#     puts "Product: #{x*y}"
# end
#
# result = math(5, 4) do |x, y|
#     { sum: x + y, product: x * y }
# end
#
# puts result

def repeat(quantity)
    quantity.times { yield }
end

# repeat(3) { puts "Repeat me" }
# repear(2) { puts "again" }

#Write your own "each method"

def my_each(array)
    for item in array
     yield(item)
    end
end

# my_each([1, 3, 9, 4]) do |n|
#     puts "Got: #{n}"
# end

# def math(a, b)
#     {
#         sum: yield(a, b, :sum),
#         product: yield(a, b, :product)
#     }
# end
#
# result = math(2, 3) do |x, y, operation|
#     case operation
#     when :sum
#         x+y
#     when :product
#         x*y
#     end
# end
#
# puts result
