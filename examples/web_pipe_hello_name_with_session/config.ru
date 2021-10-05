# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

require_relative 'base'

WebPipe.load_extensions(:session)

class HelloName
  include WebPipe

  use :session, Rack::Session::Cookie, secret: 'dont_tell_anybody'
  plug :base, Base.new
  plug :fetch_name
  plug :render

  private

  def fetch_name(conn)
    if conn.params[:name]
      conn.add_session('name', conn.params[:name])
    else
      conn
    end
  end

  def render(conn)
    conn.set_response_body("Hello, #{conn.fetch_session('name')}!")
  end
end

run HelloName.new
