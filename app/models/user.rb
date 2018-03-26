class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX, message: "please key in valid email" }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }, allow_nil: true
    validates :status, presence: true

    enum status: [:admin, :regular]

    scope :search_name, -> (name){ where("name ILIKE ?", "%#{name}%") }

    has_many :friends, :foreign_key => :user1_id
	has_many :reverse_friends, class_name: :Friend, foreign_key: :user2_id
    has_many :users, :through => :friends, :source => :user2
    
    def following?(user) 
        self.users.include?(user)
    end

    def followed?(user)
        self.reverse_friends.each do |friendship|
            if friendship.user1_id == user.id 
                return true 
                # return will break method when true
            end
        end
        return false
    end    

    def friends?(user)
        following?(user) && followed?(user)
    end
    
    # # Returns the hash digest of the given string.
    # def User.digest(string)
    #     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    #     BCrypt::Password.create(string, cost: cost)
    # end

end
