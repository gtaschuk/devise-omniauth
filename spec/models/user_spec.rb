require 'spec_helper'

describe User do
  describe "#twitter" do
    it "fetches the user from the twitter client" do
      # https://github.com/thoughtbot/factory_girl
      
      user = FactoryGirl.create(:user) 
      
      # Verifies that Twitter::Client.new is called with the 
      # given arguments, but does not actually call it
      Twitter::Client.should_receive(:new).with(
        :oauth_token => "the token", 
        :oauth_token_secret => "the secret") 
      user.twitter("the token", "the secret")
    end

    it "returns nil if there is an exception in the twitter client" do
      user = FactoryGirl.create(:user)

      # an exception will be raised when Twitter::Client.new 
      # is called
      Twitter::Client.stub!(:new).and_raise("On no!") 

      # in RSpec a be_(.*) matcher function will call `\1?` 
      # and verify that its result is truthy
      # E.g.: foo.should be_nil is essentially assert(foo.nil?)
      user.twitter("tok","sec").should be_nil 
    end

    it "returns the retrieved twitter user when all is well" do
      user = FactoryGirl.create(:user) 
      # Just an empty object to match against below
      stub_twitter_user = stub("twitter user") 

      # creates a dummy object when Twitter::Client.new is called
      Twitter::Client.stub!(:new).and_return(stub_twitter_user) 
      # valid shorthand: stub!(:new => stub_twitter_user)
      user.twitter("tok","sec").should == stub_twitter_user
    end
  end
end

