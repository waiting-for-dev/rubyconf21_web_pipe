# frozen_string_literal: true

require 'web_pipe'
require 'web_pipe/plugs/config'
require 'web_pipe/plugs/content_type'

WebPipe.load_extensions(:params)

class Base
  include WebPipe

  use :session, Rack::Session::Cookie, secret: 'dont_tell_anybody'
  plug :content_type, WebPipe::Plugs::ContentType.('text/plain')
  plug :config, WebPipe::Plugs::Config.(
    param_transformations: [:deep_symbolize_keys]
  )
end
