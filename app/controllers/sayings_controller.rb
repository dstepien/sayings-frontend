class SayingsController < ApplicationController

  def index
    @sayings = JSON.parse RestClient.get 'http://localhost:8080/sayings-1.0-SNAPSHOT/rest/sayings'.to_str
  end

  def new
    @saying = {}
    if params.include? :saying
      RestClient.post 'http://localhost:8080/sayings-1.0-SNAPSHOT/rest/sayings',
        { content: params[:saying], author: params[:author] }.to_json, content_type: :json, accept: :json
    end
  end

  def edit
    @saying = JSON.parse RestClient.get('http://localhost:8080/sayings-1.0-SNAPSHOT/rest/sayings/' + params[:id]).to_str
    if params.include? :saying
      RestClient.put 'http://localhost:8080/sayings-1.0-SNAPSHOT/rest/sayings',
        { content: params[:saying], author: params[:author], id: params[:id] }.to_json, content_type: :json, accept: :json
      flash[:success] = 'Saying updated successfully'
      redirect_to controller: 'sayings', action: 'index'
    end
  end

  def remove
    if params.include? :id
      if params.include? :confirmation
        RestClient.delete('http://localhost:8080/sayings-1.0-SNAPSHOT/rest/sayings/' + params[:id])
        flash[:success] = 'Saying deleted successfully'
        redirect_to controller: 'sayings', action: 'index'
      else
        @saying = JSON.parse RestClient.get('http://localhost:8080/sayings-1.0-SNAPSHOT/rest/sayings/' + params[:id]).to_str
      end
    end
  end
end