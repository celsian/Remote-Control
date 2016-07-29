class GpioHeadOpenWorker
  include Sidekiq::Worker
  require 'rubygems'

  #Formerly 11, but reduced the button press duration by 0.5, so increasing wait time to reflect.
  TIME_IT_TAKES_DOOR_TO_TRAVEL_TO_HEAD_LEVEL = 11

  def perform(remote_control_id)
    GpioOpenWorker.perform_async(remote_control_id)
    sleep TIME_IT_TAKES_DOOR_TO_TRAVEL_TO_HEAD_LEVEL
    GpioOpenWorker.perform_async(remote_control_id)
  end

end
