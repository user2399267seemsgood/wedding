ActiveAdmin.register Gift do
  permit_params :name, :description, :image, :image_url, :purchase_link, :price_range, :claimed, :claimer_name, :claimer_email

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :claimed
    column :claimer_name
    column :claimer_email
    column "Image" do |gift|
      if gift.image.attached?
        image_tag gift.image, size: "50x50"
      elsif gift.image_url.present?
        image_tag gift.image_url, size: "50x50"
      end
    end
    column "Price Range", :price_range
    column "Purchase Link" do |gift|
      if gift.purchase_link.present?
        link_to "Buy here", gift.purchase_link, target: "_blank"
      end
    end
    actions
  end

  form do |f|
    f.inputs "Gift Details" do
      f.input :name
      f.input :description
      f.input :claimed
      f.input :claimer_name
      f.input :claimer_email

      f.input :image, as: :file, 
                      hint: f.object.image.attached? ? image_tag(f.object.image, size: "100x100") : "No image uploaded"
      f.input :image_url, label: "Or provide an image URL"

      f.input :purchase_link, label: "Link to buy the gift"
      f.input :price_range, as: :radio, collection: ["$", "$$", "$$$"], label: "Price Range"
    end
    f.actions
  end
  
  before_save do |gift|
    if gift.image_url.present? && !gift.image.attached?
      gift.download_image_from_url
    end
  end

  show do
    attributes_table do
      row :name
      row :description
      row :claimed
      row :claimer_name
      row :claimer_email
      row "Image" do |gift|
        if gift.image.attached?
          image_tag gift.image, size: "150x150"
        elsif gift.image_url.present?
          image_tag gift.image_url, size: "150x150"
        end
      end
      row "Purchase Link" do |gift|
        if gift.purchase_link.present?
          link_to "Buy here", gift.purchase_link, target: "_blank"
        end
      end
      row :price_range
    end
  end

  action_item :unclaim, only: :show do
    if gift.claimed
      link_to "Unclaim Gift", unclaim_admin_gift_path(gift), method: :post
    end
  end
end

