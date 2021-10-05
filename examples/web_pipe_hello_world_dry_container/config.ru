# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

require 'web_pipe'
require 'dry-container'

Container = Dry::Container.new
Container.register('plugs.content_type', lambda do |conn|
  conn.add_response_header('Content-Type', 'text/plain')
end)
Container.register('plugs.render', lambda do |conn|
  conn.set_response_body('Hello, World!')
end)

class HelloWorld
  include WebPipe.(container: Container)

  plug :content_type, 'plugs.content_type'

  plug :render, 'plugs.render'
end

run HelloWorld.new
