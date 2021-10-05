# frozen_string_literal: true

# config.ru
# Execute it with `rackup` and go to http://localhost:9292

require_relative 'base'

DB = {
  users: [
    Struct.new(:name).new('Alice'),
    Struct.new(:name).new('Joe')
  ].freeze
}.freeze

class HelloName
  include WebPipe

  plug :base, Base.new
  plug :fetch_name
  plug :authorize
  plug :render

  private

  def fetch_name(conn)
    conn.add(:name, conn.params[:name])
  end

  def authorize(conn)
    if DB[:users].map(&:name).include?(conn.fetch(:name))
      conn
    else
      conn
        .set_status(401)
        .set_response_body('Get out of here!')
        .halt
    end
  end

  def render(conn)
    conn.set_response_body("Hello, #{conn.fetch(:name)}!")
  end
end

run HelloName.new
