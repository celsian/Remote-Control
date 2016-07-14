require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  describe "GET #index" do
    context "user logged in and admin" do
      it "returns http success" do
        sign_in admin

        get :index

        expect(response).to have_http_status(:success)
      end

      it "shows the proper note count" do
        sign_in admin

        get :index

        expect(assigns(:note_count)).to eq(Note::NOTE_COUNT)
      end
    end

    context "user logged in and not admin" do
      it "denies user" do
        sign_in user

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

  describe "GET #notes" do
    let!(:notes) { create_list(:note, 3) }

    before(:each) do
      sign_in admin
    end

    it "returns http success" do
      get :notes

      expect(response).to have_http_status(:success)
    end

    it "retrieves all notes" do
      get :notes

      expect(assigns(:notes)).to eq(notes.reverse)
    end
  end

  describe "GET #access_control" do
    before(:each) do
      sign_in admin
    end

    let(:remote_controls) { create_list(:remote_control, 3) }

    it "returns http success" do
      get :access_control

      expect(response).to have_http_status(:success)
    end

    it "fetches remote_controls" do
      get :access_control

      expect(assigns(:remote_controls)).to eq(remote_controls)
    end
  end

  describe "GET #access_control_enable" do
    before(:each) do
      sign_in admin
    end

    let(:remote_control) { create(:remote_control_disabled) }
    let(:params) { { id: remote_control.id } }

    it "enables the specified remote_control" do
      get :access_control_enable, params

      expect((remote_control.reload).enabled).to be(true)
    end

    it "redirects to admin_access_control_path" do
      get :access_control_enable, params
      expect(response).to redirect_to(admin_access_control_path)
    end
  end

  describe "GET #access_control_disable" do
    before(:each) do
      sign_in admin
    end

    let(:remote_control) { create(:remote_control) }
    let(:params) { { id: remote_control.id } }

    it "disabled the specified remote_control" do
      get :access_control_disable, params

      expect((remote_control.reload).enabled).to be(false)
    end

    it "redirects to admin_access_control_path" do
      get :access_control_disable, params

      expect(response).to redirect_to(admin_access_control_path)
    end
  end

  
end