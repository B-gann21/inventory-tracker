class Item < ApplicationRecord
  belongs_to :user
 
  validates_presence_of :name,  :quantity, :price, :category 

  validates_inclusion_of :favorite, in: [true, false]

  validates_numericality_of :quantity, :price

  enum category: ['food/drink', 
                  'household/kitchen',
                  'other',
                  'tools/hardware'] 
end
