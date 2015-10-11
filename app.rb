require 'sinatra/base'

class App < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
  end

  helpers do

  end

  # Function allows both get / post.
  def self.get_or_post(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end

  get '/' do
    puts "home"
  end
end
