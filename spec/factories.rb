FactoryGirl.define do
  factory :user do
    provider "twitter"
    uid      "twitter_uid"
    email    "factory@gregtaschuk.com"
    password Devise.friendly_token[0,20]
  end
end
