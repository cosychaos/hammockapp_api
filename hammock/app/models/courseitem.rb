class Courseitem < ActiveRecord::Base


  def check_cloned_status(user)
    clone = cloned_by_current_user(user)
    clone ? clone.status : false
  end

  private


  def cloned_by_current_user(user)
    user.courses.find {|course| course.name == self.name } if user
  end


end
