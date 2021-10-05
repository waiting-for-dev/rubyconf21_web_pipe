# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

require 'web_pipe'
require 'web_pipe/plugs/content_type'

WebPipe.load_extensions(:params)

class HelloName
  include WebPipe

  plug :content_type, WebPipe::Plugs::ContentType.('text/plain')
  plug :fetch_name
  plug :render

  private

  def fetch_name(conn)
    conn.add(:name, conn.params['name'])
  end

  def render(conn)
    conn.set_response_body("Hello, #{conn.fetch(:name)}!")
  end
end

run HelloName.new
