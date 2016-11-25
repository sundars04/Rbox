class Recipe < ApplicationRecord

  has_many :ingredients, inverse_of: :recipe
  has_many :directions, inverse_of: :recipe
  belongs_to :user

  scope :sorted, -> {order("created_at DESC")}

  validates :title, presence: true, length: {minimum: 5, maximum: 100}
  validates :description, presence: true, length: {minimum: 10}

  has_attached_file :image, styles: { medium: "400x400#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_size :image, :less_than => 2.megabytes

  accepts_nested_attributes_for :ingredients,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :directions,
                                reject_if: proc { |attributes| attributes['step'].blank? },
                                allow_destroy: true
  acts_as_commentable                                

end
