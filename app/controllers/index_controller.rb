require 'rest_client'

class IndexController < ApplicationController

  def index
    response = RestClient.get 'http://localhost:8080/say-1.0-SNAPSHOT/rest/say'
    @saying = response.to_str
  end
end
