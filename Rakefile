desc "Update main."
task :update_main do
  require "net/http"

  if ENV["PING_MAIN"]
  	puts "Updating main."
    uri = URI(ENV["PING_MAIN"])
    Net::HTTP.get_response(uri)
  end
end
