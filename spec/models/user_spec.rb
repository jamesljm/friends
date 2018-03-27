require 'rails_helper'

# describe - wrap a set against one functionality
# context - wrap a set against one functionality of the same state

RSpec.describe User, type: :model do
  let(:user){User.create(name: "sheng", email: "sheng@gmail.com", password: "123456", status: "regular")}
  let(:user2){User.create(name: "shen", email: "shen@gmail.com", password: "123456", status: "regular")}

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
    
    # it "only allows unique email" do
    it "should return false" do
      user
      x = User.new(name: "sheng", email: "Sheng@gmail.com", password: "123456", status: "regular")
      expect(x.save).to be false  
    end        
  end  

  # testing active record associations using shoulda-matchers
  context "active record associations " do
    it { is_expected.to have_many(:friends).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:friends)}
  end

  describe "#following?" do
    # happy path
    context "with valid params" do
      it "should return true" do
        user
        user2
        user.users << user2
        expect(user.following?(user2)).to be true
      end
    end
    
    # unhappy path
    context "with invalid params" do
      it "should return false" do
        user
        expect(user.following?(user)).to be false
      end
    end    
  end  
  
  # test followed
  describe "#followed?" do
    # happy path
    context "with valid params" do
      it "should return true" do
        user
        user2
        user.users << user2
        expect(user2.followed?(user)).to be true
      end
    end
    
    # unhappy path
    context "with invalid params" do
      it "should return false" do
        user
        expect(user.followed?(user)).to be false
      end
    end    
  end
  
  # test friends
  describe "#followed?" do
    # happy path
    context "with valid params" do
      it "should return true" do
        user
        user2
        user.users << user2
        user2.users << user
        expect(user2.friends?(user)).to be true
      end
    end
    
    # unhappy path
    context "with invalid params" do
      it "should return false" do
        user
        user2
        user.users << user2
        expect(user.friends?(user2)).to be false
      end
    end    
  end

  # test password, length, and secure
  context "test passwords" do
    it "should have a password" do
      user.password = nil
      user.save
      expect(user).to_not be_valid
    end

    it "should have a password not shorter than 6" do
      user.password = "a" * 5
      user.save
      expect(user).to_not be_valid
    end

    it "should have a matched password confirmation" do
      user.password = "123456"
      user.password_confirmation = "asdfasdf"
      user.save
      expect(user).to_not be_valid            
    end
  end

  # test scope
  context "#search_name" do
    it "should return search results" do
      user
      result = User.search_name(user.name)
      expect(result).to eq([user])
    end
  end
end
