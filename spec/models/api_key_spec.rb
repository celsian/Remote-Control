require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  let(:cu) { create(:controller_user) }
  let(:apikey) { create(:api_key, user: cu) }

  it "update_token" do
    old_token = apikey.token

    apikey.update_token

    expect(apikey.token).to_not eq(old_token)
  end
end
