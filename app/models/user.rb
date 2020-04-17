class User < ApplicationRecord
  has_many :events, foreign_key: :creator_id, class_name: 'Event'
  
  
  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { maximum: 30 }, allow_nil: false

end
