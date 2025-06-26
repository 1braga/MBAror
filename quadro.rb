module Greeting
    def hello
        super
        puts "#{Person.ancestors}"
        puts "Hello from the Greeting module"
    end

    def bye
        puts "Goodbye from the Greeting module!"
    end
end

class Person
    #include Greeting
    #extend Greeting

    def hello
        puts "Hello from Person module"
    end
end

my_person = Person.new
my_person.hello
