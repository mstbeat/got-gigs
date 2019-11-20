class Gig < ApplicationRecord
  belongs_to :user
  has_many :gig_parts
  # has_many :parts, through: :gig_parts
  has_many :entries, dependent: :destroy
  before_save :parts_array
  before_save :parts_nil

  with_options presence: true do
    validates :name
    validates :location
    validates :genre
    validates :parts
  end

  def parts_nil
    if self.parts.blank?
      self.parts = nil
      errors.add(:parts, "募集パートを選択してください")
    end
  end

  # validate  :parts_list_validation

  # def parts_list_validation
  #   parts_validation = self.parts
  #   parts_validation.split(",")
  #   if parts_validation.length < 1
  #     errors.add(:parts, "募集パートを選択してください")
  #   end
  # end

  def parts_array
    self.parts.gsub!(/[\[\]\"]/, "").gsub!(" ","") if attribute_present?("parts")
  end

  # before_save do
  #   self.parts.split(',').map{|m| m.delete('[]"\\\\')} if attribute_present?("parts")
  # end
end
