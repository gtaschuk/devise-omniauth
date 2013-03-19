require 'spec_helper'

describe Users::OmniauthCallbacksController do
  describe "GET twitter" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user] 
      # Create the auth stub to match user created above
      @request.env["omniauth.auth"] = OmniAuth::AuthHash.new ({
        provider: "twitter",
        uid: "twitter_uid",
        credentials: {
        token: "the token", 
        secret: "the secret"
      },
        info: {
        email: "greg@gregtaschuk.com"
      }
      })

    end

    it "finds user when user exists" do
      # Create the user we'll find
      u = FactoryGirl.create(:user) 

      User.should_receive(:find_by_provider_and_uid).with(
        "twitter", 
        "twitter_uid"
      )

      get :twitter

      @user = User.find_by_uid("twiiter_uid")
      @user.should_not be_nil
    end

    it "creates user when user doesn't exist" do
      User.should_receive(:find_by_provider_and_uid).with(
        "twitter", 
        "twitter_uid"
      )

      User.should_receive(:create).with(
        provider: "twitter", 
        uid:      "twitter_uid",
        email: "greg@gregtaschuk.com",
        password: anything()
      )

      get :twitter

      @user = User.find_by_uid("twiiter_uid")
      @user.should_not be_nil
    end
  end  
end
