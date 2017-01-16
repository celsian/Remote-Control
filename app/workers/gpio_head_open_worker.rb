class GpioHeadOpenWorker
  include Sidekiq::Worker
  require 'rubygems'

  TIME_IT_TAKES_DOOR_TO_TRAVEL_TO_HEAD_LEVEL = 12

  def perform(remote_control_id)
    GpioOpenWorker.perform_async(remote_control_id)
    sleep TIME_IT_TAKES_DOOR_TO_TRAVEL_TO_HEAD_LEVEL
    GpioOpenWorker.perform_async(remote_control_id)
  end

end
