module RescueDog
  class Dog
    attr_accessor :groomed, :healthy, :ate, :ready,
      :name, :age, :breed

    def initialize(args)
      args = defaults.merge(args)
      @name = args[:name]
      @age = args[:age]
      @breed = args[:breed]
      @ate = args[:ate]
      @groomed = args[:groomed]
      @healthy = args[:healthy]
      @ready = args[:ready]
    end

    def defaults
      { groomed: false, healthy: false, ate: false, ready: false }
    end

    def tasks_complete?
      groomed && healthy && ate && ready
    end

    def groomed?
      groomed
    end

    def healthy?
      healthy
    end

    def ate?
      ate
    end

    def ready?
      ready
    end

    def to_json
      JSON.generate({
        name: name,
        age: age,
        breed: breed,
        ate: ate,
        groomed: groomed,
        healthy: healthy,
        ready: ready
      })
    end
  end
end

