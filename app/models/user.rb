class User < ApplicationRecord
  # enum monday: [ :off, :on ]
  # enum tuesday: [ :off, :on ]
  # enum wednsday: [ :off, :on ]
  # enum thursday: [ :off, :on ]
  # enum friday: [ :off, :on ]
  # enum saturday: [ :off, :on ]
  # enum sunday: [ :off, :on ]
  # enum workoutTime: 

  scope :reset, ->(reset) { update(monday: reset, tuesday: reset, wednsday: reset, thursday: reset, friday: reset, saturday: reset, sunday: reset) }
end
