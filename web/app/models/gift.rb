class Gift < ApplicationRecord
  has_one_attached :image  

  validates :name, presence: true

  validate :correct_image_type

  private

  def correct_image_type
    if image.attached? && !image.content_type.in?(%w(image/png image/jpg image/jpeg))
      errors.add(:image, 'must be a PNG, JPG, or JPEG')
    end
  end
end

