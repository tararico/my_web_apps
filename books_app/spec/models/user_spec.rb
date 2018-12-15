require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it "is invalid without a name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
  end
  describe "find_or_create_for_oauth" do
    context "userが登録されている場合" do
      it "登録されているuserを返すこと" do
        user = User.create(
          name: "TestUser",
          email: "sample@test.com",
          provider: "facebook",
          password: "password"
        )
        class MockAuth
          def initialize(user)
            @user = user
          end
          def provider
            "facebook"
          end
          def uid
            @user.uid
          end
          def info
            MockInfo.new
          end
        end
        class MockInfo
          def name
            "TestUser"
          end
          def email
            "sample@test.com"
          end
        end
        auth = MockAuth.new(user)
        expect(User.find_or_create_for_oauth(auth).email).to eq("sample@test.com")
      end
    end
    context "userが登録されていない場合" do
      xit "userを登録すること" do
        expect().to eq
      end
      xit "登録したuserを返すこと" do
        expect().to eq
      end
    end
  end
end
