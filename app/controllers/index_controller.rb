require 'rest_client'

class IndexController < ApplicationController

  def index
    @saying = RestClient.get 'http://localhost:8080/say-1.0-SNAPSHOT/rest/say'.to_str
  end
end
