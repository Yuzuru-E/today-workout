class User < ApplicationRecord
  enum sunday: [ :off, :on ]
  enum monday: [ :off, :on ]
  enum tuesday: [ :off, :on ]
  enum wednsday: [ :off, :on ]
  enum thursday: [ :off, :on ]
  enum friday: [ :off, :on ]
  enum saturday: [ :off, :on ]
  enum workoutTime: 
end
