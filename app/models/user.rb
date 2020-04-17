class User < ApplicationRecord
  
  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { maximum: 30 }, allow_nil: false

end
