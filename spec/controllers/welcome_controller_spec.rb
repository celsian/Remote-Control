require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:controller_user) { create(:controller_user) }

  describe "GET #index" do
    it "redirects guest to login" do
      get :index

      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects controllers to the remote_controls index" do
      sign_in controller_user

      get :index

      expect(response).to redirect_to(remote_controls_path)
    end
  end
end