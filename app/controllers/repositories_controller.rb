class RepositoriesController < ApplicationController

  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @username = JSON.parse(user.body)['login']

    repos = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    @repo_data = JSON.parse(repos.body)
  end

  def create
    response = Faraday.post("https://github.com/user/repos") do |req|
      req.params['name'] = params[:name]
      req.params['Authorization'] = params[:authenticity_token]
    end


      # , { name: params[:name], 'Authorization' => "token #{params[:access_token]}", 'Accept' => 'application/json'})

    # raise response.inspect
    # body = JSON.parse(response.body)
    #
    raise response.inspect
  end
end
