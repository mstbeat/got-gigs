class Part < ApplicationRecord
  belongs_to :gig

  validates :name, presence: true
end
