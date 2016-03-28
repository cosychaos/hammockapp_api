class Course < ActiveRecord::Base

  belongs_to :user
  has_many :course_modules
  after_initialize :init


  def init
    self.status ||= "interested"
  end


end
