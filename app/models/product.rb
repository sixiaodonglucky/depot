class Product < ActiveRecord::Base
	puts "111111111111111111111111111111111---------------3333"
	validates :title, :description, :image_url, presence: true
	#validates :name, presence: true
end
