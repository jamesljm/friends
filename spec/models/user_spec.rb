require 'rails_helper'

# describe - wrap a set against one functionality
# context - wrap a set against one functionality of the same state

RSpec.describe User, type: :model do

  context "validations" do
    # testing columns and respective types
		it "has name as string" do
			should have_db_column(:name).of_type(:string)
		end
    
		it "has status as integer" do
			should have_db_column(:status).of_type(:integer)
    end

    it "has phone as string" do
      should have_db_column(:phone).of_type(:string)
    end 
    
    it "has address as string" do
      should have_db_column(:address).of_type(:string)
    end 

    it "has address as string" do
      should have_db_column(:address).of_type(:string)
    end 

    # testing validations using shoulda-matchers
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:status) }
  
    # testing emails with correct and incorrect values
    it { is_expected.to allow_value("good@email.com").for(:email) }
    it { is_expected.not_to allow_value("bad@email").for(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    
  end  

  # testing active record associations using shoulda-matchers
  context "active record associations " do
    it { is_expected.to have_many(:friends).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:friends)}
  end
  
  let(:user){ User.create(name: 'hello', email: 'hello@gmail.com') }
  let(:user2){ User.create(name: 'goodbye', email: 'goodbye@gmail.com')}

  describe "#following?" do
    # happy path
    context "with valid params" do
      it "should return true" do
        user.users << user2
        expect(Friend.all).not_to be_empty
        expect(user.users).to include user2
      end
    end
    
    # unhappy path
  end  

  # test password, length, and secure
  # test scope
end
