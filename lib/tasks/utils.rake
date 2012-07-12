namespace :utils do

  desc "import_qx "
  task(:import_qx,[:file]  => :environment) do |t,args|
    require 'csv'
    
    CSV::Reader.parse(File.open(args[:file])) do |row|
      if row[0] and row[1]
        Qx.create({:code=>row[0],:name=>row[1]})
        
      end
    end
  end

  desc "import_school "
  task(:import_school,[:file]  => :environment) do |t,args|
    require 'csv'
    School.delete_all
    CSV::Reader.parse(File.open(args[:file])) do |row|
      if row[0] and row[2] and row[3]
        if qx=Qx.find_by_code(row[0])
        School.create({:code=>row[2],:name=>row[3],:qx_id=>qx.id})
        end
      end
    end
  end

  desc "create_user "
  task(:create_user  => :environment) do
    User.delete_all("not login='admin'")
    require 'csv'
    CSV.open('users.csv', 'w') do |writer|


    School.all.each do |school|
      pwd=User.generate_password
      User.create({:login=>school.code,:name=>school.code,:email=>"#{school.code}@g.com",:school_id=>school.id,:password=>pwd,:password_confirmation=>pwd})
      writer <<[school.name,school.code,pwd]
    end
    end
    
  end

  desc "create_admin "
  task(:create_admin  => :environment) do
    User.delete("login='admin'")
      pwd='123456'
      User.create({:login=>'admin',:name=>'admin',:email=>"admin@g.com",:password=>pwd,:password_confirmation=>pwd,:is_admin=>true})
  end

  desc "create_qx_admin "
  task(:create_qx_admin  => :environment) do
    #User.delete("login='admin'")
      pwd='123456'
      Qx.all.each do |qx|
        User.create({:login=>qx.code,:name=>qx.code,:email=>"#{qx.code}@g.com",:password=>pwd,:password_confirmation=>pwd,:is_admin=>true,:qx_id=>qx.id})
      end
      
  end

  desc "changepassword"
  task(:change_pwd=>:environment) do
    pwd='123456'
    User.all.each do |user|
      user.update_attributes(:password=>pwd,:password_confirmation=>pwd)
    end
  end
end