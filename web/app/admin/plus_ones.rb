# frozen_string_literal: true

ActiveAdmin.register PlusOne do
  permit_params :guest_id, :first_name, :last_name, :diet, :child

  # Default sorting by first_name asc, then last_name asc
  config.sort_order = 'id_dsc'
  controller do
    def scoped_collection
      if params[:order].blank?
        super.reorder(first_name: :asc, last_name: :asc)
      else
        super
      end
    end
  end

  form do |_f|
    inputs 'Plus One' do
      input :guest, as: :select, collection: Guest.all.map { |g| ["#{g.first_name} #{g.last_name}", g.id] }, prompt: "Select a Guest"
      input :first_name
      input :last_name
      input :diet, as: :text
      input :child
    end
    actions
  end

  # Customize looks
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :diet
    column :child
    column :guest
    actions
  end
  
  config.per_page = 500
end
