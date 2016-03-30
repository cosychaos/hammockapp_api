class Courseitem < ActiveRecord::Base

  def cloned_by_current_user?(user)
    user.courses.any? {|course| course.name == self.name }
  end

end
