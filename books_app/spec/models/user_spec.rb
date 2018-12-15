require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it "is invalid without a name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
  end
  describe "from_omniauth" do
    context "userが登録されている場合" do
      it "登録されているuserを返すこと" do
        user = User.create(
          name: "TestUser",
          email: "sample@test.com",
          provider: "facebook",
          password: "password"
        )
        expect(User.from_omniauth(auth).email).to eq("sample@test.com")
      end
    end
    context "userが登録されていない場合" do
      it "userを登録すること" do
        expect().to eq
      end
      it "登録したuserを返すこと" do
        expect().to eq
      end
    end
  end
end
