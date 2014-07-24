class GpioWorker
  include Sidekiq::Worker
  require 'rubygems'
  require 'pi_piper'

  def perform(remote_control_id)
    remote_control = RemoteControl.find(remote_control_id)
    
    pin = PiPiper::Pin.new(:pin => remote_control.gpio, :direction => :out)
    sleep 1
    pin.on
  end

end