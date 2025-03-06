class Gift < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :price_range, inclusion: { in: ["$", "$$", "$$$"], allow_nil: true }

  validate :image_format

  def image_source
    return image if image.attached?
    return image_url if image_url.present?
    
    "placeholder.jpg" # Default image if neither is provided
  end

  private

  def image_format
    return unless image.attached?

    if !image.content_type.in?(%w(image/png image/jpg image/jpeg))
      errors.add(:image, "must be a PNG or JPG")
    end
  end
end

