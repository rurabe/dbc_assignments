require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'database')

#create the table in the database

ActiveRecord::Base.connection.execute <<-SQL
  CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR NOT NULL,
    last_name  VARCHAR NOT NULL,
    birthday   DATE,
    gender     VARCHAR(8),
    email      VARCHAR,
    phone      VARCHAR,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
SQL

#create a model (add relations if more than one table)
class Student < ActiveRecord::Base

end

naruto = Student.new( :first_name => "Naruto", 
                      :last_name => "Uzumaki",
                      :birthday => "10/10/1985",
                      :gender => "male",
                      :email => "naruto@konoha.mil",
                      :phone => "777-777-7777")

akuma = Student.new(  :first_name => "Akuma", 
                      :last_name => "Sarutobi",
                      :birthday => "7/10/1970",
                      :gender => "male",
                      :email => "akuma@konoha.mil",
                      :phone => "777-777-8888")
                      
minato = Student.new( :first_name => "Minato", 
                      :last_name => "Namikaze",
                      :birthday => "7/7/1962",
                      :gender => "male",
                      :email => "minato@konoha.mil",
                      :phone => "777-777-4444")
                                    
naruto.save
akuma.save
minato.save

Student.all
Student.where("first_name LIKE ?","a%")
Student.where("birthday LIKE ?","%-07-%")                                       
                                            