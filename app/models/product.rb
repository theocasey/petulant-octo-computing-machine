class Product < ActiveRecord::Base

	has_many :order_products

	validates :title, presence: true
	validates :description, presence: true
	validates :price_in_pence, presence: true

	has_attached_file :image, styles: { 
		large: "960x300#", 
		medium: "300x300#",
		thumbnail: "50x50#"
	}

end
