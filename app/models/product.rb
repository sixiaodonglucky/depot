class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	default_scope {order (:title)}
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	# def validate
	# 	Errors.add(:title, t("depot.deleteRal"))  if title.empty?
	# end
	private 
		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
				image_url = self.image_url
		        path = "#{Rails.root}/app/assets/images/" + image_url
		          if File.exists?(path)
		             File.delete(path)
		          end   
				return true
			else
				# errors.add(:base,'sssssssssss')
				# errors.add(:error, t("depot.deleteRal")) 
				errors[:error] << "ssssss"
				return false
			end
		end
end
