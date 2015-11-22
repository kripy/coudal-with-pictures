require "sinatra/base"
require "nokogiri"
require "httparty"
require "aws-sdk"
require "rss"
require "uri"

class App < Sinatra::Base
  configure do
    set :root, File.dirname(__FILE__)
  end

  helpers do
    def get_url_from_description(str_text)
      # puts str_text
      str_text = URI.extract(str_text.inner_text, ["http", "https"])
      arr_url = str_text.to_a

      if arr_url.count > 0
        if arr_url.count >= 2
          if arr_url[0].include? "http"
            str_the_url = arr_url[0]
          else
            str_the_url = arr_url[1]
          end
        else
          str_the_url = arr_url[0]
        end
      end
    end

    def get_meta_image_from_html(str_url)
      # puts str_url
      response = HTTParty.get(str_url)
      str_html = Nokogiri::HTML(response.body)

      str_meta_image = ""
      str_meta_image = str_html.xpath("//meta[@property='og:image']/@content")
      if str_meta_image.length > 0
        str_meta_image = "<img src=\"#{str_meta_image}\" />"
      end
    end
  end

  # Function allows both get / post.
  def self.get_or_post(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end

  get "/" do
    response = HTTParty.get("http://feeds.feedburner.com/CoudalFreshSignals")
    doc = Nokogiri::XML(response.body)

    @links = doc.xpath('//item').map do |i|
      str_title = i.xpath("title").inner_text.to_s
      str_description = i.xpath("description")
      str_url = get_url_from_description(str_description)
      str_image = get_meta_image_from_html(str_url)
      str_the_description = "#{str_image} #{str_description.inner_text.to_s}"
      str_link = i.xpath("link").inner_text.to_s
      str_date = i.xpath("pubDate").inner_text.to_s

      {title: str_title, link: str_link, description: str_the_description, date: str_date}
    end

    str_rss = RSS::Maker.make("atom") do |maker|
      maker.channel.author = "Kripy"
      maker.channel.updated = Time.now.to_s
      maker.channel.about = "http://kcdn.kripy.com/coudal/index.xml"
      maker.channel.title = "CP: Fresh Signals (With Pictures)"

      @links.map do |i|
        maker.items.new_item do |item|
          item.link = i[:link]
          item.title = i[:title]
          item.content.content = i[:description]
          item.content.type = "html"
          item.updated = i[:date]
        end
      end
    end

    # Set up S3 object.
    s3 = Aws::S3::Client.new(
      access_key_id:      ENV["S3_KEY"],
      secret_access_key:  ENV["S3_SECRET"],
      region:             "us-east-1"
    )

    bucket_name = "kcdn.kripy.com"
    key = "coudal/index.xml"
    s3.put_object(bucket: bucket_name, key: key, body: str_rss.to_s, acl: "public-read")

    puts "Made RSS at #{Time.now}."
  end
end
