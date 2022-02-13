class Album < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :artist, presence: true
  validates :name, presence: true
  validates :year, presence: true, length: { is: 4 }
end
