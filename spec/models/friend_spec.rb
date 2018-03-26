require 'rails_helper'

RSpec.describe Friend, type: :model do
  #testing raise_error
  let(:user){ User.create(name: 'hello', email: 'hello@gmail.com')}
  let(:user2){ User.create(name: 'goodbye', email: 'goodbye@gmail.com')}

  describe "no_add_self" do
    # happy path
    it "raises_error" do 
      expect { Friend.create(user1_id: 1, user2_id: 1) }.to raise_error("kenot add self")
      # expect {user.users << user}.to raise_error(:same)
    end
    
    # unhappy path
  end
  
end
