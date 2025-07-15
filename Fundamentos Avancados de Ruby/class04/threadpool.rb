require 'thread'

class PriorityQueue
    PRIORITIES = [:high, :medium, :low]

    def initialize
        @queues = {}
        @mutex = Mutex.new
        PRIORITIES.each do |priority|
        @queues[priority] = Queue.new
        end
    end

    def push(priority, task)
        raise ArgumentError, "Prioridade inválida" unless PRIORITIES.include?(priority)

        @queues[priority] << task
    end

    def pop
        loop do
        @mutex.synchronize do
            PRIORITIES.each do |priority|
            return @queues[priority].pop(true) unless @queues[priority].empty?
            end
        end
        sleep 0.01
        rescue ThreadError
        next
        end
    end

    def empty?
        @mutex.synchronize do
        @queues.values.all?(&:empty?)
        end
    end
end

class DynamicThreadPool
    def initialize(max_threads:)
        @max_threads = max_threads
        @task_queue = PriorityQueue.new
        @threads = []
        @mutex = Mutex.new
        @shutdown = false
        spawn_thread # cria ao menos uma thread
    end

    def schedule(priority = :medium, &block)
        raise ArgumentError, "É necessário um bloco" unless block_given?

        @task_queue.push(priority, block)

        @mutex.synchronize do
        clean_dead_threads
        if @threads.size < @max_threads && busy_thread_count >= @threads.size
            spawn_thread
        end
        end
    end

    def shutdown
        @shutdown = true
        @threads.each(&:join)
    end

    private

    def spawn_thread
        thread = Thread.new do
        loop do
            break if @shutdown && @task_queue.empty?

            task = @task_queue.pop
            begin
            task.call
            rescue => e
            warn "Erro ao executar tarefa: #{e.message}"
            end
        end
        end
        @threads << thread
    end

    def clean_dead_threads
        @threads.reject! { |t| !t.alive? }
    end

    def busy_thread_count
        @threads.count { |t| t.status == "run" }
    end
end

pool = DynamicThreadPool.new(max_threads: 3)

10.times do |i|
    pool.schedule(:medium) { sleep 1; puts "Tarefa padrão #{i} concluída" }
end

5.times do |i|
    pool.schedule(:high) { sleep 0.5; puts "Tarefa prioritária #{i} concluída" }
end

pool.shutdown
