module Trackable
    def self.included(base)
        puts "#{self} "
        base.extend(ClassMethods)
    end

    def track_instance
        puts "track at instance level: Line: #{__LINE__}"
    end

    def track
        puts "tracking at class level: Line: #{__LINE__}"
    end

    module ClassMethods
        def track_class
            puts "tracking at class level: Line: #{__LINE__}"
        end

        def track
            puts "tracking at ?: Line: #{__LINE__}"
        end
    end
end

class User
    include Trackable
end

User.new.track_instance
User.track_class
User.track
