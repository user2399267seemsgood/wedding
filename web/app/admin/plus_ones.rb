# frozen_string_literal: true

ActiveAdmin.register PlusOne do
  permit_params :guest_id, :first_name, :last_name, :diet, :child

  form do |_f|
    inputs 'Plus One' do
      input :guest, as: :select, collection: Guest.pluck(:first_name, :last_name, :id), prompt: "Select a Guest"
      input :first_name
      input :last_name
      input :diet, as: :text
      input :child
    end
    actions
  end
end
