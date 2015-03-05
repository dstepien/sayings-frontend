class SayingsController < ApplicationController

  def index
    @sayings = JSON.parse RestClient.get 'http://localhost:8080/say-1.0-SNAPSHOT/rest/sayings'.to_str
  end

  def new
    if params.include? :saying
      RestClient.post 'http://localhost:8080/say-1.0-SNAPSHOT/rest/sayings',
        { content: params[:saying], author: params[:author] }.to_json, content_type: :json, accept: :json
    end
  end

  def remove
    if params.include? :id
      if params.include? :confirmation
        RestClient.delete('http://localhost:8080/say-1.0-SNAPSHOT/rest/sayings/' + params[:id])
        flash[:success] = 'Saying deleted successfully'
        redirect_to controller: 'sayings', action: 'index'
      else
        @saying = JSON.parse RestClient.get('http://localhost:8080/say-1.0-SNAPSHOT/rest/sayings/' + params[:id]).to_str
      end
    end
  end
end