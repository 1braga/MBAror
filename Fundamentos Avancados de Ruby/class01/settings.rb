class Settings
    def initialize
        @configs = {}
    end

    def add(key, value)
        @configs[key] = value

        define_singleton_method(key) do
        @configs[key]
        end
    end

    def method_missing(name, *args, &block)
        if @configs.key?(name)
            @configs[name]
        else
            "Configuração '#{name}' não existe."
        end
    end

    def respond_to_missing?(name, include_private = false)
        @configs.key?(name) || super
    end
end

settings = Settings.new

settings.add(:timeout, 30)
settings.add(:mode, "production")

puts settings.timeout
puts settings.mode
puts settings.retry
puts settings.respond_to?(:timeout)
puts settings.respond_to?(:retry)
