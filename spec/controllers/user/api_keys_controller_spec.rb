require 'rails_helper'

RSpec.describe User::ApiKeysController, type: :controller do
  describe "POST create" do
    let(:user) { create(:user) }
    let(:controller_without_key) { create(:controller_user) }

    it "creates an api_key for the currently logged in controller" do
      sign_in controller_without_key

      expect { post :create }.to change { ApiKey.count }.by(1)
    end

    it "does not create an api_key for a non controller user" do
      sign_in user

      expect { post :create }.to change { ApiKey.count }.by(0)
    end
  end

  describe "PATCH update" do
    let(:controller) { create(:controller_user) }
    let(:apikey) { create(:api_key, user: controller) }

    it "updates an api_key for the currently logged in user" do
      sign_in controller

      patch :update, params: { id: apikey.id }

      expect(apikey.token).to_not eq(ApiKey.find(apikey.id).token)
    end
  end

  describe "DELETE destroy" do
    let(:controller) { create(:controller_user) }
    let!(:apikey) { create(:api_key, user: controller) }

    it "deletes the api_key for the currently logged in user" do
      sign_in controller

      expect { delete :destroy, params: { id: apikey.id } }.to change { ApiKey.count }.by(-1)
      expect(ApiKey.find_by(id: apikey.id)).to be(nil)
    end
  end
end