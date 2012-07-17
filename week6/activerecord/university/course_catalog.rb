require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'database')
  
ActiveRecord::Base.connection.execute <<-SQL
  DROP TABLE IF EXISTS people
SQL

ActiveRecord::Base.connection.execute <<-SQL
  DROP TABLE IF EXISTS courses
SQL

ActiveRecord::Base.connection.execute <<-SQL
  DROP TABLE IF EXISTS sections
SQL

ActiveRecord::Base.connection.execute <<-SQL
  DROP TABLE IF EXISTS sectiontypes
SQL

ActiveRecord::Base.connection.execute <<-SQL
  DROP TABLE IF EXISTS rosters
SQL

ActiveRecord::Base.connection.execute <<-SQL
  DROP TABLE IF EXISTS departments
SQL

ActiveRecord::Base.connection.execute <<-SQL
  -- Teachers and students go in this table
  -- The 'staff' field is true for teachers, false for students
  CREATE TABLE  IF NOT EXISTS people (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    email      VARCHAR(128) NOT NULL,
    staff      BOOLEAN NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
SQL

ActiveRecord::Base.connection.execute <<-SQL
  CREATE TABLE  IF NOT EXISTS courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    department_id INTEGER NOT NULL,
    name          VARCHAR NOT NULL,
    created_at    DATETIME NOT NULL,
    updated_at    DATETIME NOT NULL,
    FOREIGN KEY(department_id) REFERENCES departments(id)
  );
SQL

ActiveRecord::Base.connection.execute <<-SQL
  CREATE TABLE  IF NOT EXISTS sections (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id        INTEGER NOT NULL,
    teacher_id      INTEGER NOT NULL,
    sectiontype_id INTEGER NOT NULL,
    start_time      DATETIME NOT NULL,
    end_time        DATETIME NOT NULL,
    created_at      DATETIME NOT NULL,
    updated_at      DATETIME NOT NULL,
    FOREIGN KEY(course_id) REFERENCES courses(id),
    FOREIGN KEY(teacher_id) REFERENCES people(id),
    FOREIGN KEY(sectiontype_id) REFERENCES sectiontypes(id)
  );
SQL

ActiveRecord::Base.connection.execute <<-SQL
  -- e.g., 'MWF', 'TuTh'
  CREATE TABLE  IF NOT EXISTS sectiontypes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(32) NOT NULL
  );
SQL

ActiveRecord::Base.connection.execute <<-SQL
  -- Grade is a decimal from 0.000 to 4.000
  CREATE TABLE  IF NOT EXISTS rosters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    section_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    grade DECIMAL(4,3),
    FOREIGN KEY(section_id) REFERENCES sections(id),
    FOREIGN KEY(student_id) REFERENCES people(id)
  );
SQL

ActiveRecord::Base.connection.execute <<-SQL
  CREATE TABLE  IF NOT EXISTS departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(32) NOT NULL
  );
SQL

class Person < ActiveRecord::Base
  has_many :rosters
  has_many :sections, :through => :rosters, :foreign_key => "student_id"
  has_many :courses, :through => :sections
  has_many :sections, :foreign_key => "teacher_id" #teacher
end

class Course < ActiveRecord::Base
  has_many :sections
  has_many :people, :through => :rosters
  belongs_to :department
end

class Section < ActiveRecord::Base
  has_many :rosters
  has_many :people, :through => :rosters
  belongs_to :course
  belongs_to :sectiontype
  belongs_to :teacher, :class_name => "Person" #teacher_id is implicit
end

class Sectiontype < ActiveRecord::Base
  has_many :sections
end

class Roster < ActiveRecord::Base
  belongs_to :person
  belongs_to :section
end

class Department < ActiveRecord::Base
  has_many :courses
end


#Commands-------------------------------------

marshall = Department.new(:name => "Business")
marshall.save

mw = Sectiontype.new(:name => "MWF")
mw.save

naruto = Person.new(  :first_name => "Naruto",
                      :last_name => "Uzumaki",
                      :email => "naruto@konoha.com",
                      :staff => false)
naruto.save
                     
finance = marshall.courses.build(:name => "Finance 307")
accounting = marshall.courses.build(:name => "Accounting 250a")
econ = marshall.courses.build(:name => "Economics 350")
marshall.save

monday_morning_finance = finance.sections.build(:start_time => "08:00", :end_time => "10:00")
monday_morning_finance.sectiontype = mw
# monday_morning_finance.people << naruto
# monday_morning_finance.save





