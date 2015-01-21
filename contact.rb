require 'pg'
require 'pry'
class Contact
  attr_accessor :fname,
                :lname,
                :email,
                :phone
  attr_reader   :id
  def initialize(fname, lname, email, phone, id=nil)
    @fname = fname
    @lname = lname
    @email = email
    @phone = phone
    @id = id
  end

  def save
    if !id.nil?
      sql = "UPDATE contacts SET firstname=$1, lastname=$2, email=$3, phone=$4 WHERE id=$5"
      self.class.connection.exec_params(sql, [fname, lname, email, phone, id])
    else
      sql = "INSERT INTO contacts (firstname, lastname, email, phone)
              VALUES('#{fname}', '#{lname}', '#{email}', '#{phone}')"
      self.class.connection.exec(sql)
    end
      true
    rescue PG::Error => e
      false 
  end

  def destroy
    sql = "DELETE FROM contacts WHERE id=#{id}"
    self.class.connection.exec(sql)
    true
  rescue PG::Error => e
    false
  end

  class << self
    def connection
      PG.connect(dbname: 'dagp4ovl7oef84', 
                 port: 5432, 
                 host: 'ec2-54-83-9-127.compute-1.amazonaws.com',
                 user: 'ibuynmtvtzvuyx',
                 password: 'vldm7UKmRCwPHj95Tjuh3_RuI6')
    end

    def dummy_contact(row)
      Contact.new(row["firstname"], row["lastname"], 
                  row["email"], row["phone"], row["id"])
    end

    def find(id)
      sql = "SELECT * FROM contacts WHERE id=#{id}"
      row = connection.exec(sql)[0]
          contact = dummy_contact(row)
      contact
    end

    def find_by_email(email)
      sql = "SELECT * FROM contacts WHERE email='#{email}'"
      row = connection.exec(sql)[0]
          contact = dummy_contact(row)
      contact
    end

    def find_all_by_lastname(name)
      sql = "SELECT * FROM contacts WHERE lastname='#{name}'"
      rows = connection.exec(sql)
      contacts = []
      rows.each do |row|
        contact = dummy_contact(row)
        contacts << contact
      end
      contacts
    end

    def find_all_by_firstname(name)
      sql = "SELECT * FROM contacts WHERE firstname='#{name}'"
      rows = connection.exec(sql)
      contacts = []
      rows.each do |row|
        contact = dummy_contact(row)
        contacts << contact
      end
      contacts
    end    
  end
end