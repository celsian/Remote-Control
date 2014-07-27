class GpioHeadOpenWorker
  include Sidekiq::Worker
  require 'rubygems'

  def perform(remote_control_id)
    GpioOpenWorker.perform_async(remote_control_id)
    sleep 11
    GpioOpenWorker.perform_async(remote_control_id)
  end

end