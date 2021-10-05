# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

hello_world = lambda do |_env|
  [200, { 'Content-Type' => 'text/plain' }, ['Hello, World!']]
end

class DecoratorMiddleware
  def initialize(app, decorated_text)
    @app = app
    @decorated_text = decorated_text
  end

  def call(env)
    status, headers, body = @app.call(env)

    [status, headers, ["#{body[0]} #{@decorated_text}"]]
  end
end

use DecoratorMiddleware, '__one__'
use DecoratorMiddleware, '__two__'
run hello_world
