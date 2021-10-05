# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

hello_world = lambda do |_env|
  [200, { 'Content-Type' => 'text/plain' }, ['Hello, World!']]
end

class DecoratorMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    env['decorated'] = 'decorated'

    status, headers, body = @app.call(env)

    [status, headers, ["#{body[0]} #{env['decorated']}"]]
  end
end

run DecoratorMiddleware.new(hello_world)
