class Course < ActiveRecord::Base

  belongs_to :user


  def initialize
    super
    self.status ||= "interested"
  end

end
