require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    it "is invalid without a name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
  end
end
