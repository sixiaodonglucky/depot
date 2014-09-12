class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy

	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantuty += 1
		else
			puts "55555555555555555555: "+current_item.to_s
			current_item = line_items.build(:product_id => product_id)
		end
		current_item
    end
end
