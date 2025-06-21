# frozen_string_literal: true

ActiveAdmin.register Attendee do
  scope :child?
  scope :diet?

  # Default sorting by first_name asc, then last_name asc
  config.sort_order = 'first_name_asc'
  controller do
    def scoped_collection
      if params[:order].blank?
        super.reorder(first_name: :asc, last_name: :asc)
      else
        super
      end
    end
  end

  index do
    column :first_name
    column :last_name
    column :email
    column :diet
    column :songs
    column :notes
    column :child
    column :updated_at
  end

  config.batch_actions = false
  config.filters = false
  config.per_page = 500
  config.clear_action_items!
end
