## simulating long api calls

module API
  class Groomer
    def self.groom(dog)
      puts "Vacuuming #{dog.name}"
      sleep 10
      dog.groomed = true
      dog
    end
  end

  class Vet
    def self.check(dog)
      puts "Checking #{dog.name}"
      sleep 5
      dog.healthy = true
      dog
    end
  end

  class Trainer
    def self.feed(dog)
      puts "Checking #{dog.name}"
      sleep 3
      dog.ate = true
      dog
    end
  end

  class ProspectiveOwners
    def self.notify(dog)
      puts "Mailed letters to humans. '#{dog.name} ready for a home'"
      sleep 2
      dog.ready = true
      dog
    end
  end
end
