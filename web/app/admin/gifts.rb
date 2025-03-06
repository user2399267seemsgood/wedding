ActiveAdmin.register Gift do
  permit_params :name, :description, :image, :claimed, :claimer_name, :claimer_email

  index do
    selectable_column
    id_column
    column :name
    column :description
    column "Image" do |gift|
      if gift.image.attached?
        image_tag url_for(gift.image), size: "50x50"
      end
    end
    column :claimed
    column :claimer_name
    column :claimer_email
    actions
  end

  form do |f|
    f.inputs "Gift Details" do
      f.input :name
      f.input :description
      f.input :image, as: :file
      f.input :claimed
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :image do |gift|
        if gift.image.attached?
          image_tag url_for(gift.image), size: "150x150"
        end
      end
      row :claimed
      row :claimer_name
      row :claimer_email
    end
    active_admin_comments
  end

  member_action :unclaim, method: :post do
    gift = Gift.find(params[:id])
    gift.update(claimed: false, claimer_name: nil, claimer_email: nil)
    redirect_to admin_gifts_path, notice: "Gift unclaimed."
  end

  action_item :unclaim, only: :show do
    if resource.claimed
      link_to "Unclaim Gift", unclaim_admin_gift_path(resource), method: :post
    end
  end
end

