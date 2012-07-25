class Product < ActiveRecord::Base
  attr_accessible :description, :imageurl, :price, :size, :title
  
  validates_presence_of :title, :price, :description, :imageurl, :size
  validates :title, :length => { :maximum => 50 }, :uniqueness => { :case_sensitive => false }
  validates :description, :length => { :maximum => 250 }
  validates :price, :format => { :with => /[\d\,]*\.\d{2}$/ }
  validates :imageurl, :format => { :with => /#{URI::regexp}\.(jpg|png|gif)$/i }
  validates :size, :inclusion => { :in => %w(small medium large) }
end
