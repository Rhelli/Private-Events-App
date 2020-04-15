class User < ApplicationRecord
  
  before_save { self.name = name.downcase }
  validates :name, presence: true, allow_nil: false

end
