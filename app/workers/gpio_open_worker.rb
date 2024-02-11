class GpioOpenWorker
  include Sidekiq::Job
  require 'rubygems'

  if Rails.env.production?
    include Pigpio::Constant
  end

  def perform(remote_control_id)
    remote_control = RemoteControl.find(remote_control_id)

    if Rails.env.production?
      pi = Pigpio.new

      gpio = pi.gpio(remote_control.gpio.to_i)
      gpio.mode = PI_OUTPUT
      gpio.pud = PI_PUD_OFF

      gpio.write 1
      sleep 1.0
      gpio.write 0

      pi.stop
    end
  end
end
