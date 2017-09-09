module RescueDog
  class Connection
    def initialize
      @connection ||= establish_connection
      @channel ||= @connection.create_channel
      @queue ||= @channel.queue("tasks")
    end

    private

    def establish_connection
      conn = Bunny.new
      conn.start
    end

    def prefetch
      channel.prefetch(1)
      puts "Waiting on dogs"
    end
  end

  class TaskProducer < Connection
    def initialize(body)
      super()
      @body = body
    end

    attr_reader :connection, :channel, :queue, :body

    def submit
      @queue.publish(body, persistent: true)
      puts "!!! dog submitted to queue"
    end
  end
end

module RescueDog
  class TaskConsumer < Connection
    def initialize
      super()
      prefetch
    end

    attr_reader :connection, :channel, :queue

    def receive
      queue.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
        puts " [x] Received '#{body}'"
        Controller.delegate JSON.parse(body)
        channel.ack(delivery_info.delivery_tag)
      end
    end
  end
end

module RescueDog
  class Controller
    def self.delegate(hash)
      symbolized_hash = hash.reduce({}) { |m, (k,v)| m[k.to_sym] = v; m}
      dog = Dog.new(symbolized_hash)

      if !dog.healthy?
        API::Vet.check dog
      elsif !dog.groomed?
        API::Groomer.groom dog
      elsif !dog.ate?
        API::Trainer.feed dog
      elsif !dog.ready?
        API::ProspectiveOwners.notify dog
      end

      if dog.tasks_complete?
        puts "Tasks complete for #{dog.name}"
        puts dog.to_json
      else
        requeue dog
      end
    end

    def self.requeue(dog)
      TaskProducer.new(dog.to_json).submit
    end
  end
end
