require 'faraday'
require 'faraday_middleware'

module SimpleJira
  class Client
    module Comments
      def list_comments(issue_id)
        begin
          connection = Faraday.new(:url => "#{@jira_url}/rest/api/2/issue/#{issue_id}/comment") do |c|
            c.use Faraday::Request::UrlEncoded
            c.use FaradayMiddleware::FollowRedirects
            c.use FaradayMiddleware::Mashify
            c.use FaradayMiddleware::ParseJson
            c.use Faraday::Adapter::NetHttp
          end
          connection.basic_auth(@login, @password)

          response = connection.get
          raise "#{response.inspect}" if response.status != 200
          response.body.comments
        rescue => e
          raise "Error when trying to list comments of #{issue_id}: #{e}"
        end
      end

      def create_comment(issue_id, comment)
        begin
          connection = Faraday.new(:url => "#{@jira_url}/rest/api/2/issue/#{issue_id}/comment") do |c|
            c.use Faraday::Request::UrlEncoded
            c.use FaradayMiddleware::FollowRedirects
            c.use FaradayMiddleware::Mashify
            c.use FaradayMiddleware::ParseJson
            c.use Faraday::Adapter::NetHttp
          end
          connection.basic_auth(@login, @password)

          response = connection.post do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = "{\"body\":\"#{comment}\"}"
          end
          raise "#{response.inspect}" if response.status != 201
        rescue => e
          raise "Error when trying to create comment on #{issue_id}: #{e}"
        end
      end
    end
  end
end
