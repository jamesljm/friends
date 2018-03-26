class Friend < ApplicationRecord
    belongs_to :user1, class_name: :User
    belongs_to :user2, class_name: :User
    validate :no_add_self

    def no_add_self
        errors.add(:same, "kenot add self") if user1_id == user2_id
    end
end
