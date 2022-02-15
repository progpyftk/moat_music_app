# frozen_string_literal: true

require 'json'
require 'rest-client'

# albums helper
module AlbumsHelper
  def fetch_artist_list
    url = 'https://moat.ai/api/task/'
    resp = RestClient.get(url, headers = { Basic: 'ZGV2ZWxvcGVyOlpHVjJaV3h2Y0dWeQ==' })
  rescue RestClient::Unauthorized, RestClient::Forbidden => e
    e.response
  rescue RestClient::ImATeapot => e
    e.response
  else
    resp
  end

  def artists_names
    artist_list = []
    obj_array = JSON.parse(fetch_artist_list).flatten
    obj_array.each do |artist|
      artist_list << artist['name']
    end
    artist_list
  end
end
