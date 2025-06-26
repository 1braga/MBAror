# block
# 5.times { |n| puts "#{n} is odd" if n.odd? }

3.times do |n| #n=0/1/2
    result = n * 2 #n=0/2/4
    return if result == 2 #early return / guard-clause
    puts "hey #{result}"
    puts "New line"
    puts "Another line"
end

[1, 2, 4, 9].each { |i| puts "#{i}" }
[1, 2, 4, 9].each do |a|
    puts "#{a}"
end
