class SessionsController < ApplicationController
  # skip when you're creating a session, or end up in an infinite loop of trying to figure out who the user is
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
      # correct credentials? GitHub sends response - includes headers and body
      # sent as string that must be parsed
      # within the body is an access token unique to this specific request
    end
    # parses the response body into a Ruby hash and stores this hash as the body variable
    body = JSON.parse(response.body)
    # need this token whenever we send API requests
    session[:token] = body["access_token"]
    redirect_to root_path
    # authenticate_user is called again
  end
end
