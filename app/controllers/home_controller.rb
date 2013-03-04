class HomeController < ApplicationController


  def index
    if current_user
      twit = current_user.twitter(session[:twitter_token],session[:twitter_secret])
      @tweets = twit.home_timeline
      puts @tweets
    end

  end
end
