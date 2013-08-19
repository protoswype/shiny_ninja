class Project < ActiveRecord::Base
  attr_accessible :comment, :customer_id, :name, :timebudget
  
  # associations
  belongs_to :customer
  has_and_belongs_to_many :users
  
  # validations
  validates :comment, :customer_id, :name, :timebudget,
    :format => {:with => /^[^<>%&$]*$/}
  validates :name, :presence => true
  validates :customer_id, :presence => true
  
  # search
  def self.search(search, current_user)
    
    customers = current_user.customers
    result = Project.where( :customer_id => customers)
    
    if search
      if search["name"].present?
        result = result.where('name LIKE ?', "%" + search["name"] + "%")
      end
      if search["customer"].present?
        result = result.where('customer_id = ?', search["customer"])
      end    
    end
    result.order("name")
  end
end
