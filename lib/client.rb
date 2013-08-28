require_relative 'worklog.rb'
require_relative 'comments.rb'
require_relative 'transitions.rb'

module SimpleJira
  class Client
    attr_accessor :login
    attr_accessor :password
    attr_accessor :jira_url

    def initialize(options = {})
      begin
        if options.has_key?(:login) && options.has_key?(:password) && options.has_key?(:jira_url)
          @login = options[:login]
          @password = options[:password]
          @jira_url = options[:jira_url]
        else
          raise "Client creation requires a login, password, and jira_url to be specified"
        end
      rescue => e
        raise "Error when trying to create client: #{e} - #{e.backtrace}"
      end
    end

    include SimpleJira::Client::Worklog
    include SimpleJira::Client::Comments
    include SimpleJira::Client::Transitions
  end
end
