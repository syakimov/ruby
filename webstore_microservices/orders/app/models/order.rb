class Order < ApplicationRecord

  validates :user_id, presence: true
  validates :total, presence: true

end
