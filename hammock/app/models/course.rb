class Course < ActiveRecord::Base

  belongs_to :user
  has_many :course_modules
  after_initialize :init


  def init
    self.status ||= "interested"
  end

  def self.build_with_clone(attributes = {}, courseitem, current_user)
    courseitem.attributes.map {|key, value| attributes[key] = value }
    attributes[:id] = nil
    attributes[:user_id] = current_user.id
    self.new(attributes)
  end


end
