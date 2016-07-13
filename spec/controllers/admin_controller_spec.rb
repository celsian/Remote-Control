require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe "GET #index" do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }

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
    let(:admin) { create(:admin) }
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

end