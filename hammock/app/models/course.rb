class Course < ActiveRecord::Base

  belongs_to :user
  after_initialize :init


  def init
    self.status ||= "interested"
  end


end
