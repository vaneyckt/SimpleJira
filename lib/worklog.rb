require 'faraday'
require 'Time'

module SimpleJira
  class Client
    module Worklog
      def list_workLog(issue_id)
        begin
          connection = Faraday.new(:url => "#{@jira_url}/rest/api/2/issue/#{issue_id}/worklog") do |c|
          c.use Faraday::Request::UrlEncoded
          c.use FaradayMiddleware::FollowRedirects
          c.use FaradayMiddleware::Mashify
          c.use FaradayMiddleware::ParseJson
          c.use Faraday::Adapter::NetHttp
        end
          connection.basic_auth(@login, @password)

          response = connection.get
          raise "#{response.worklogs}" if response.status != 200
          response.body.worklogs
        rescue => e
          raise "Error when trying to list comments of #{issue_id}: #{e} - #{e.backtrace}"
        end
      end      
    end
  end
end
