class Api::V1::RemoteControlsController < Api::V1::BaseController
  def open
    remote_control = RemoteControl.find(params[:id])
    json = {id: RemoteControl.first.id, name: RemoteControl.first.name}

    if remote_control.open(@user)
      json.merge!({
        "success":true,
        "message":"The #{remote_control.name} was triggered at #{Time.now.strftime("%I:%M:%S %p on %m-%d-%Y")}."
      })
    else
      json.merge!({
        "success":false,
        "message":"The #{remote_control.name} trigger failed, it is disabled."
      })
    end

    render json: json
  end
end