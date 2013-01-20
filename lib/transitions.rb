require 'faraday'
require 'faraday_middleware'

module SimpleJira
  class Client
    module Transitions
      def list_available_transitions(issue_id)
        begin
          connection = Faraday.new(:url => "#{@jira_url}/rest/api/2/issue/#{issue_id}/transitions") do |c|
            c.use Faraday::Request::UrlEncoded
            c.use FaradayMiddleware::FollowRedirects
            c.use FaradayMiddleware::Mashify
            c.use FaradayMiddleware::ParseJson
            c.use Faraday::Adapter::NetHttp
          end
          connection.basic_auth(@login, @password)

          response = connection.get
          raise "#{response.inspect}" if response.status != 200
          response.body.transitions
        rescue => e
          raise "Error when trying to list available transitions of #{issue_id}: #{e}"
        end
      end

      def set_transition(issue_id, transition_id)
        begin
          connection = Faraday.new(:url => "#{@jira_url}/rest/api/2/issue/#{issue_id}/transitions") do |c|
            c.use Faraday::Request::UrlEncoded
            c.use FaradayMiddleware::FollowRedirects
            c.use FaradayMiddleware::Mashify
            c.use FaradayMiddleware::ParseJson
            c.use Faraday::Adapter::NetHttp
          end
          connection.basic_auth(@login, @password)

          response = connection.post do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = "{\"transition\":{\"id\":\"#{transition_id}\"}}"
          end
          raise "#{response.inspect}" if response.status != 204
        rescue => e
          raise "Error when trying to set transition on #{issue_id}: #{e}"
        end
      end
    end
  end
end
