require 'thor'

module Dozenscli
  class List < Thor
    def initialize(*args)
      super
      @api = API.new
    end

    desc 'zone', 'Return a list of zones'
    def zone
      puts JSON.pretty_generate(@api.get_zone)
    end

    desc 'record', 'Return a list of records for the provided zone'
    option :zone, :required => true, :type => :string
    def record
      puts JSON.pretty_generate(@api.get_record(options[:zone]))
    end
  end

  class Create < Thor
    def initialize(*args)
      super
      @api = API.new
    end

    desc 'zone', 'Create a new zone'
    option :name, :required => true, :type => :string
    def zone
      puts JSON.pretty_generate(@api.create_zone(options[:name]))
    end

    desc 'record', 'Create a new record'
    option :params, :required => true, :type => :string
    def record
      puts JSON.pretty_generate(@api.create_record(options[:params]))
    end
  end

  class Delete < Thor
    def initialize(*args)
      super
      @api = API.new
    end

    desc 'zone', 'Delete a zone'
    option :id, :required => true, :type => :string
    def zone
      puts JSON.pretty_generate(@api.delete_zone(options[:id]))
    end

    desc 'record', 'Delete a record'
    option :id, :required => true, :type => :string
    def record
      puts JSON.pretty_generate(@api.delete_record(options[:id]))
    end
  end

  class Update < Thor
    def initialize(*args)
      super
      @api = API.new
    end

    desc 'record', 'Update an existing record'
    option :id, :required => true, :type => :string
    option :params, :required => true, :type => :string
    def record
      puts JSON.pretty_generate(@api.update_record(options[:id], options[:params]))
    end
  end

  class Command < Thor
    desc 'list TYPE', 'List resource. Type can be zone, record'
    subcommand 'list', List

    desc 'create TYPE', 'Create resource. Type can be zone, record'
    subcommand 'create', Create

    desc 'delete TYPE', 'Delete resource. Type can be zone, record'
    subcommand 'delete', Delete

    desc 'update TYPE', 'Update resource. Type can be record'
    subcommand 'update', Update
  end
end
