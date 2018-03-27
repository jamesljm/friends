require 'rails_helper'

RSpec.describe Friend, type: :model do
  #testing raise_error
  let(:user){User.create(name: "sheng", email: "sheng@gmail.com", password: "123456", status: "regular")}
  let(:user2){User.create(name: "shen", email: "shen@gmail.com", password: "123456", status: "regular")}

  describe "no_add_self" do
    # happy path
    it "raises_error" do 
      user
      user2
      x = Friend.new(user1_id: user.id, user2_id: user.id)
      expect( x.save ).to be false
      # expect {user.users << user}.to raise_error(:same)
    end
    
    # unhappy path
    it "should return params with valid params" do
      user
      user2
      x = Friend.new(user1_id: user.id, user2_id: user2.id)
      expect( x.save ).to be true
    end
  end
  
end
