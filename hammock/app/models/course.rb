class Course < ActiveRecord::Base

  belongs_to :user
  has_many :course_modules, dependent: :destroy
  after_initialize :init


  def init
    self.status ||= "interested"
  end

  def self.build_with_clone(courseitem, current_user, status = 'interested')
    attributes = {}
    courseitem.attributes.map {|key, value| attributes[key] = value }
    attributes[:status] = status
    attributes[:id] = nil
    attributes[:user_id] = current_user.id
    self.new(attributes)
  end

  def self.build_with_user(params, current_user)
    params[:user_id] ||= current_user.id
    self.new(params)
  end


end
