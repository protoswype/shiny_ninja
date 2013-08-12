# encoding: UTF-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :registerable
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable
  
  attr_accessible :bank_account_number, :bank_name, :bank_code, :city,
    :comment, :country, :created_by, :email, :firstname, :lastname, :login,
    :password, :password_confirmation, :phone_number, :remember_me, :roles,
    :roles_mask, :signature, :street, :street_number, :tax_number, :zipcode
  
  # associations
  has_many :customers
  has_and_belongs_to_many :projects
  
  # validations
  validates :login, :presence => true,
    :uniqueness => {:case_sensitive => false}
  validates :password, :length => { :minimum => 5, :maximum => 40},
    :confirmation => true,
    :on => :create
  validates :password, :length => { :minimum => 5, :maximum => 40},
    :confirmation => true,
    :allow_blank => true,
    :on => :update
  validates :email, :presence => true,
    :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/},
    :uniqueness => {:case_sensitive => false}
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  
  
  ROLES = %w[administrator time_tracker project_evaluator]
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end
  
  # search
  def self.search(search, current_user)

    result = User.where("created_by = ? OR id = ?", current_user.id, current_user.id)
    
    if search
      if search["firstname"].present?
        result = result.where("firstname LIKE ?", search["firstname"])
      end
      if search["lastname"].present?
        result = result.where("lastname LIKE ?", search["lastname"])
      end
    end
    result.order("lastname ASC")
  end
  
end
