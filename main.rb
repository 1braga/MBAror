# class Dog
#     def nothing
#
#     end
#
#     def bark
#         puts "Woff!"
#     end
#
#     def self.sit
#         puts "I'm sitting!"
#     end
# end
#
# mydog = Dog.new
# mydog.bark
# Dog.sit

class Cat
    puts "In class, self is #{self}"

    def meow
        puts "In an instance method, self is #{self}"
    end

    def self.meow
        puts "In an class method, self is #{self}"
    end
end

# kitty = Cat.new
# kitty.meow
Cat.meow
