class School < ActiveRecord::Base
  belongs_to :qx
  has_many :users
  has_many :score_files

  def score_file_for(exam)
    self.score_files.find_by_exam_id(exam.id)
  end
end
