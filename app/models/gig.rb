class Gig < ApplicationRecord
  belongs_to :user
  has_many :gig_parts
  # has_many :parts, through: :gig_parts
  has_many :entries, dependent: :destroy
  validates :datetime, timeliness: { on_or_after: Time.now }
  before_save :parts_array
  before_save :parts_nil
  validates :parts, presence: true

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
    self.parts.split(",")
  end

  def self.search(search)
    if search
      Gig.where('name LIKE(?) or DATE_FORMAT(datetime, "%Y年%m月%d日") LIKE(?) or location LIKE(?) or genre LIKE(?) or parts LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Gig.all
    end
  end

  # before_save do
  #   self.parts.split(',').map{|m| m.delete('[]"\\\\')} if attribute_present?("parts")
  # end
end
