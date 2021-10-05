# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

require_relative 'base'

class HelloName
  include WebPipe

  plug :base, Base.new
  plug :fetch_name
  plug :render

  private

  def fetch_name(conn)
    conn.add(:name, conn.params[:name])
  end

  def render(conn)
    conn.set_response_body("Hello, #{conn.fetch(:name)}!")
  end
end

run HelloName.new(
  plugs: {
    render: ->(conn) { conn.set_response_body('Injected hello') }
  }
)
