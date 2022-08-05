class Item < ApplicationRecord
  belongs_to :user
 
  validates_presence_of :name,  :quantity, :price, 
                        :favorite, :category

  validates_numericality_of :quantity, :price

  enum category: ['food/drink', 
                  'tools/hardware', 
                  'household/kitchen',
                  'other']
end
