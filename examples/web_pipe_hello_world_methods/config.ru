# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

require 'web_pipe'

class HelloWorld
  include WebPipe

  plug :content_type

  plug :render

  private

  def content_type(conn)
    conn.add_response_header('Content-Type', 'text/plain')
  end

  def render(conn)
    conn.set_response_body('Hello, World!')
  end
end

run HelloWorld.new
