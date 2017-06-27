class Order < ApplicationRecord
  attr_accessor(:user)

  validates :user_id, presence: true
  validates :total, presence: true

end
