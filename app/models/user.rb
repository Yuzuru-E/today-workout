class User < ApplicationRecord
  enum monday: [ :off, :on ]
  enum tuesday: [ :off, :on ]
  enum wednsday: [ :off, :on ]
  enum thursday: [ :off, :on ]
  enum friday: [ :off, :on ]
  enum saturday: [ :off, :on ]
  enum sunday: [ :off, :on ]
  enum workoutTime: 

  scope :find_user, { User.find_by(line_id: line_id) }
  scope :workout_monday, { user[:monday] }
end
