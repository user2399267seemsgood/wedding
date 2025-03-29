# frozen_string_literal: true

ActiveAdmin.register Guest do
  permit_params :email, :first_name, :last_name, :attending, :diet, :songs,
                :notes, :allowed_plus_ones

  scope :confirmed
  scope :attending
  scope :not_attending

  form do |_f|
    inputs 'Guest' do
      input :email, as: :string, required: false
      input :first_name
      input :last_name
      input :allowed_plus_ones
      input :attending
      input :diet, as: :text
      input :songs, as: :text
      input :notes, as: :text
    end
    actions
  end
end
