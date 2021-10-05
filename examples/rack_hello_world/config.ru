# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

hello_world = lambda do |_env|
  [200, { 'Content-Type' => 'text/plain' }, ['Hello, World!']]
end

run hello_world
