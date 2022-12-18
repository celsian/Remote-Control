require 'rails_helper'

RSpec.describe Api::V1::RemoteControlsController, type: :controller do
  let(:controller_user) { create(:controller_user) }
  let(:apikey_cu) { create(:api_key, user: controller_user) }
  let(:user) { create(:user) }
  let(:apikey_u) { create(:api_key, user: user) }
  let(:remote_control) { create(:remote_control) }
  let(:remote_control_disabled) { create(:remote_control_disabled) }

  describe "GET open" do
    context "when a controller user with valid api key" do
      before(:each) do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(apikey_cu.token)
      end

      context "opens a remote control that exists" do
        it "it opens" do
          params = { id: remote_control.id }
          get :open, params: params, format: 'json'

          expect(JSON.parse(response.body)).to include("success" => true)
        end
      end

      context "opens a remote control that does not exist" do
        it "returns an error" do
          get :open, params: { id: "dude" }

          body = JSON.parse(response.body)
          expect(body).to include("success" => false)
          expect(body).to include("message" => "ID does not exist.")
        end
      end

      context "opens a remote control that is disabled" do
        it "returns an error" do
          get :open, params: { id: remote_control_disabled }

          body = JSON.parse(response.body)
          expect(body).to include("success" => false)
        end
      end
    end

    context "when a non-controller user with valid api key" do
      before(:each) do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(apikey_u.token)
      end

      context "opens a remote control that exists" do
        it "it does not open" do
          params = { id: remote_control.id }
          get :open, params: params, format: 'json'

          expect(JSON.parse(response.body)).to include("message" => "Bad Credentials" )
        end
      end
    end
  end
end