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
          def provider
            "facebook"
          end
          def uid
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
        auth = MockAuth.new
        expect(User.find_or_create_for_oauth(auth)).to eq(user)
      end
    end
    context "userが登録されていない場合" do
      it "userが登録されること" do
        class MockAuth
          def provider
            "facebook"
          end
          def uid
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
        auth = MockAuth.new
        User.find_or_create_for_oauth(auth)
        expect(User.exists?(email: "sample@test.com")).to eq true
      end
      it "登録してuserを返すこと" do
        class MockAuth
          def provider
            "facebook"
          end
          def uid
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
        auth = MockAuth.new
        expect(User.find_or_create_for_oauth(auth)).to eq(User.find_by(email: "sample@test.com"))
      end
    end
  end
end
