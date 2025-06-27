# yield

def bark
    puts "Starting line: #{__LINE__}"
    yield if block_given?
    puts "Ending - line: #{__LINE__}"
end

def meow
    puts "Beginning: line #{__LINE__}"
    yield("Little yellow")
    yield("Little white")
    puts "Ending: line #{__LINE__}"
end

#meow { |name| puts "Name: #{name} - line #{__LINE__}" }

def say_hello
    yield("first yield")
    yield("second yield")
    yield("third yield")
end

say_hello do |n|
    puts "hello from the #{n}"
end
