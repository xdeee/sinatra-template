#!/usr/bin/env ruby -w
# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'logger'
require 'sequel'
require 'net/http'
require 'thin'
require_relative 'helpers'
require_relative 'models/init'
require_relative 'routes/init'

class MyThinBackend < ::Thin::Backends::TcpServer
  def initialize(host, port, options)
    super(host, port)
    @ssl = true
    @ssl_options = options
  end
end

configure :production do
  set :bind, '0.0.0.0'
  set :port, 4569
  set :server, 'thin'
  class << settings
    def server_settings
      {
        backend: MyThinBackend,
        private_key_file: File.dirname(__FILE__) + '/privkey.pem',
        cert_chain_file: File.dirname(__FILE__) + '/fullchain.pem',
        verify_peer: false
      }
    end
  end
end

configure :development do
  set :logging, Logger::DEBUG
end

configure :production, :test do
  set :logging, Logger::DEBUG
end
