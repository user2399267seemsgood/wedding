require 'open-uri'

class Gift < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :price_range, inclusion: { in: ["$", "$$", "$$$"], allow_nil: true }
  
  validate :image_format

  before_save :download_image_from_url, if: -> { image_url.present? && image.blank? }

  def download_image_from_url
    file = URI.open(image_url)
    filename = File.basename(URI.parse(image_url).path)
    image.attach(io: file, filename: filename, content_type: file.content_type)
  rescue => e
    Rails.logger.error "Failed to download image: #{e.message}"
  end

  private

  def image_format
    return unless image.attached?

    if !image.content_type.in?(%w(image/png image/jpg image/jpeg))
      errors.add(:image, "must be a PNG or JPG")
    end
  end
end
