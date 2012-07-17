require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'database')


ActiveRecord::Base.connection.execute <<-SQL

  CREATE TABLE IF NOT EXISTS contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR,
    last_name  VARCHAR,
    birthday   DATE,
    email      VARCHAR,
    phone      VARCHAR,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
  SQL

ActiveRecord::Base.connection.execute <<-SQL
  CREATE TABLE IF NOT EXISTS addresses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    contact_id INTEGER NOT NULL,
    street_address  VARCHAR,
    street_address2 VARCHAR,
    city            VARCHAR,
    state           VARCHAR,
    country         VARCHAR,
    zip             VARCHAR,
    FOREIGN KEY (contact_id) REFERENCES contacts(id)
  );
SQL

class Contact < ActiveRecord::Base
  has_many :addresses
  
end

class Address < ActiveRecord::Base
  belongs_to :contact
  
end

sakura = Contact.new(     :first_name =>  "Sakura",
                          :last_name  =>  "Haruno",
                          :birthday   =>  "2/08/86",
                          :email      =>  "sakura@konoha.mil",
                          :phone      =>  "777-777-1234")
                          
sakura.addresses.build(   :street_address   =>  "22 Village Lane",
                          :city             =>  "Konoha",
                          :state            =>  "KG",
                          :country          =>  "Hi no Kuni",
                          :zip              =>  "77777"
                          )                          
sakura.addresses.build(   :street_address   =>  "Hokage Palace",
                          :city             =>  "Konoha",
                          :state            =>  "CA",
                          :country          =>  "Hi no Kuni",
                          :zip              =>  "77777"
                          )                             
                          
                          
sasuke = Contact.new(     :first_name =>  "Sasuke",
                          :last_name  =>  "Uchiha",
                          :birthday   =>  "8/10/85",
                          :email      =>  "sasuke@akatsuki.com",
                          :phone      =>  "111-666-1234")
                          
sasuke.addresses.build(   :street_address   =>  "55 Uchiha Camp",
                          :city             =>  "Konoha",
                          :state            =>  "KG",
                          :country          =>  "Hi no Kuni",
                          :zip              =>  "77777"
                          )                          
sasuke.addresses.build(   :street_address   =>  "Tobi's Hideout",
                          :city             =>  "Unknown",
                          :state            =>  "CA",
                          :country          =>  "Unknown",
                          :zip              =>  "Unknown"
                          )                          

       
akuma = Contact.new(      :first_name =>  "Akuma",
                          :last_name  =>  "Sarutobi",
                          :birthday => "7/10/1970",
                          :email => "akuma@konoha.mil",
                          :phone => "777-777-8888")

akuma.addresses.build(    :street_address   =>  "Old Sarutobi House",
                          :city             =>  "Konoha",
                          :state            =>  "KG",
                          :country          =>  "Hi no Kuni",
                          :zip              =>  "77777"
                          )                          
akuma.addresses.build(    :street_address   =>  "Konoha Cemetary",
                          :city             =>  "Konoha",
                          :state            =>  "KG",
                          :country          =>  "Hi no Kuni",
                          :zip              =>  "77777"
                          )                         
                                    
sakura.save
sasuke.save
akuma.save                          
           
Contact.all
Address.all
ca_residents = Address.joins(:contact).select("addresses.*,contacts.first_name,contacts.last_name").where("addresses.state" => "CA")
a_resident_addresses = Address.joins(:contact).where("contacts.first_name LIKE ?","a%")