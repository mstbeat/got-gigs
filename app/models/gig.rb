class Gig < ApplicationRecord
  belongs_to :user
  has_many :gig_parts
  # has_many :parts, through: :gig_parts
  has_many :entries, dependent: :destroy
  before_save :parts_array

  def parts_array
    self.parts.gsub!(/[\[\]\"]/, "").gsub!(" ","") if attribute_present?("parts")
  end

  # before_save do
  #   self.parts.split(',').map{|m| m.delete('[]"\\\\')} if attribute_present?("parts")
  # end
end
