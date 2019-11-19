class Part < ApplicationRecord
  has_many :gig_parts
  # has_many :gigs, through: :gig_parts
  validates :name, presence: true

  accepts_nested_attributes_for :gig_parts
end
