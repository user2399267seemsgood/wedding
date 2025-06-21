# frozen_string_literal: true

ActiveAdmin.register Guest do
  permit_params :email, :first_name, :last_name, :attending, :diet, :songs,
                :notes, :allowed_plus_ones

  scope :confirmed
  scope :not_confirmed
  scope :attending
  scope :not_attending

  # Default sorting by first_name asc, then last_name asc
  config.per_page = 500
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
    inputs 'Guest' do
      input :email, as: :string
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

  # Allow batch selection
  batch_action :clear_confirmation, if: proc { current_admin_user } do |ids|
    Guest.where(id: ids).update_all(confirmed_at: nil)
    redirect_to collection_path, notice: "Confirmation timestamps have been removed for selected guests."
  end

  # Customize looks
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :attending
    column :allowed_plus_ones
    column :token do |guest|
      link_to guest.token, "/guests/#{guest.id}-#{guest.token}", target: "_blank"
    end
    actions
  end
end
