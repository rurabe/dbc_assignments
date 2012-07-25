class Product < ActiveRecord::Base
  attr_accessible :description, :imageurl, :price, :size, :title
  
  validates_presence_of :title, :price, :description, :imageurl, :size 
end
