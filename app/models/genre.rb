class Genre < ApplicationRecord
  has_many :movies

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }

  before_save { name.downcase! }
end
