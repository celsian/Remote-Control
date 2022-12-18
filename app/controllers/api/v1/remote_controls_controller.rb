class Api::V1::RemoteControlsController < Api::V1::BaseController
  def open
    remote_control = RemoteControl.find_by(id: params[:id])

    render json: { id: params[:id], name: "", "success": false, "message": "ID does not exist." } and return unless remote_control

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