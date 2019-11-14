class Entry < ApplicationRecord
  belongs_to :gig
  belongs_to :user

  validates :content, presence: true
end
