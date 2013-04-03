class School < ActiveRecord::Base
  belongs_to :qx
  has_many :users
  has_many :score_files
  has_many :order_items

  def score_file_for(exam)
    self.score_files.find_by_exam_id(exam.id)
  end

  def score_files_for(exam)
    self.score_files.find_all_by_exam_id(exam.id)
  end
end
