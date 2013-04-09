require 'spec_helper'

describe Users::OmniauthCallbacksController do

  describe "#twitter" do

    context "user exists" do 
      before :each do
        request.env["devise.mapping"] = Devise.mappings[:user] 
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
        user = FactoryGirl.create(:user) 
      end

      it "finds user when user exists" do
        # Create the user we'll find
        User.should_receive(:find_by_provider_and_uid).with(
          "twitter", 
          "twitter_uid"
        )
        get :twitter
        user = User.find_by_uid("twitter_uid")
        user.should_not be_nil
        response.should redirect_to(root_path)
      end
    end

    context "new user" do
      before :each do
        request.env["devise.mapping"] = Devise.mappings[:user] 
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter_two] 
        #@user = FactoryGirl.create(:user) 
      end

      it "creates user when user doesn't exist" do
        OmniAuth.config.mock_auth[:twitter_two].should be_valid 
        User.should_receive(:find_by_provider_and_uid).with(
          "twitter", 
          "another_twitter_uid"
        )

        User.should_receive(:create).with(
          provider: "twitter", 
          uid:      "another_twitter_uid",
          email:    "support@gregtaschuk.com",
          password: anything()
        ).and_return(FactoryGirl.create(:user)) 
        get :twitter
      end
    end
  end  
end
