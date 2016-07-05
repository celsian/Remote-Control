require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe "GET #index" do
    context "user logged in and admin" do
      it "returns http success" do
        sign_in FactoryGirl.create(:admin)

        get :index

        expect(response).to have_http_status(:success)
      end
    end

    context "user logged in and not admin" do
      it "denies user" do
        sign_in FactoryGirl.create(:user)

        get :index

        expect(response).to redirect_to(root_path)
      end
    end

    context "user is not logged in" do
      it "redirects user to login page" do
        get :index

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end