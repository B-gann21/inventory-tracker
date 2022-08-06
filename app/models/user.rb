class User < ApplicationRecord
  has_many :items
  has_secure_password
  validates_presence_of :email, :password_digest 
  validates_uniqueness_of :email

  def items_by_updated
    items.order(updated_at: :desc)
  end

  def items_by_category
    items.order(category: :asc)
  end 
end
