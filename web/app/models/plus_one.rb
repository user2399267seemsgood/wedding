# frozen_string_literal: true

#
# An extra guest.
#
class PlusOne < ApplicationRecord
  belongs_to :guest

  auto_strip_attributes :first_name, :last_name, :diet

  validates :first_name, presence: true
  validates :first_name, length: { maximum: 1024 }
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 1024 }

  def name
    "#{first_name} #{last_name}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["child", "created_at", "diet", "first_name", "guest_id", "id", "last_name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["guest"]
  end

  validates :diet, length: { maximum: 8192 }
end
