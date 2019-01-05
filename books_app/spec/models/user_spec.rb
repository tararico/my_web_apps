require 'rails_helper'

RSpec.describe User, type: :model do
  describe "find_or_create_for_oauth" do
    before do
      @auth = OmniAuth::AuthHash.new(
        provider: "facebook",
        info: {
          name: "TestUser",
          email: "sample@test.com"
        },
      )
    end
    context "userが登録されている場合" do
      it "登録されているuserを返すこと" do
        user = User.create(
          name: "TestUser",
          email: "sample@test.com",
          provider: "facebook",
          password: "password"
        )
        expect(User.find_or_create_for_oauth(@auth)).to eq(user)
      end
    end
    context "userが登録されていない場合" do
      it "userが登録されること" do
        User.find_or_create_for_oauth(@auth)
        expect(User.exists?(email: "sample@test.com")).to eq true
      end
      it "登録してuserを返すこと" do
        expect(User.find_or_create_for_oauth(@auth)).to eq(User.find_by(email: "sample@test.com"))
      end
    end
  end
end
