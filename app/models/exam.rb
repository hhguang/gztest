class Exam < ActiveRecord::Base
  has_many :score_files

  named_scope :active,:conditions=>{:closed=>false},:limit=>1
  
end
