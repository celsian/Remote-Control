require 'rails_helper'

RSpec.describe RemoteControlsController, type: :controller do
  let(:controller_user) { create(:controller_user) }
  let(:user) { create(:user) }

  before(:each) do
    sign_in controller_user
  end

  describe "GET index" do
    it "redirects guest to sign_in" do
      sign_out controller_user

      get :index

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects non-admin/non-controller users to root_path" do
      sign_in user

      get :index

      expect(response).to redirect_to(root_path)
    end

    it "returns http success for controllers" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end
end