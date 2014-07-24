class RemoteControl < ActiveRecord::Base
  default_scope order("name")
end
