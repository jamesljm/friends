require 'rails_helper'

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
      should have_db_column(:phone).of_type(:phone)
    end 
    
     # testing validations using shoulda-matchers
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

    # testing emails with correct and incorrect values
    it { is_expected.to allow_value("good@email.com").for(:email) }
    it { is_expected.not_to allow_value("bad@email").for(:email) }
  end  

  # testing active record associations using shoulda-matchers
  context "active record associations " do
    it { is_expected.to have_many(:friends).dependent(:destroy) }
  end
end
