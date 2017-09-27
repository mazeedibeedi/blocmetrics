require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_registered_application) { create(:registered_application, user: my_user) }

  describe "GET #index" do
    it "returns http success" do
      sign_in my_user
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_app to @registered_applications" do
      sign_in my_user
      get :index
      expect(assigns(:registered_applications)).to eq([my_registered_application])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      sign_in my_user
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      sign_in my_user
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates @registered_application" do
      sign_in my_user
      get :new
      expect(assigns(:registered_application)).not_to be_nil
    end
  end

  describe "POST #create" do
    it "increases the number of registered_applications by 1" do
      sign_in my_user
      expect{ post :create, { registered_application: { name: 'MyName', url: 'MyUrl', user: my_user }}}.to change(RegisteredApplication, :count).by(1)
    end

    it "Assigns RegisteredApplication.last to @registered_application" do
      sign_in my_user
      post :create, { registered_application: { name: 'MyName', url: 'MyUrl', user: my_user }}
      expect(assigns(:registered_application)).to eq(RegisteredApplication.last)
    end

    it "redirects to the new Registered application" do
      sign_in my_user
      post :create, { registered_application: { name: 'MyName', url: 'MyUrl', user: my_user }}
      expect(response).to redirect_to RegisteredApplication.last
    end
  end

  describe "GET #show" do
    it "returns http success" do
      sign_in my_user
      get :show, { id: my_registered_application.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      sign_in my_user
      get :show, { id: my_registered_application.id }
      expect(response).to render_template :show
    end

    it "assigns my_app to @registered_application" do
      sign_in my_user
      get :show, { id: my_registered_application.id }
      expect(assigns(:registered_application)).to eq my_registered_application
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      sign_in my_user
      get :edit, { id: my_registered_application.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      sign_in my_user
      get :edit, { id: my_registered_application.id }
      expect(response).to render_template :edit
    end

    it "assigns my_registered_application to be updated to @registered_application" do
      sign_in my_user
      get :edit, { id: my_registered_application.id }
      app_instance = assigns(:registered_application)

      expect(app_instance.id).to eq(my_registered_application.id)
      expect(app_instance.name).to eq(my_registered_application.name)
      expect(app_instance.url).to eq(my_registered_application.url)
      expect(app_instance.user).to eq(my_registered_application.user)
    end
  end

  describe "PUT #update" do
    it "updates registered_application with expected attributes" do
      sign_in my_user
      new_name = "new_name"
      new_url = "new_url"

      put :update, id: my_registered_application.id, registered_application: { name: new_name, url: new_url }

      updated_app = assigns(:registered_application)
      expect(updated_app.id).to eq(my_registered_application.id)
      expect(updated_app.name).to eq(new_name)
      expect(updated_app.url).to eq(new_url)
    end

    it "redirects to the updated registered application" do
      sign_in my_user
      new_name = "new_name"
      new_url = "new_url"

      put :update, id: my_registered_application.id, registered_application: { name: new_name, url: new_url }

      expect(response).to redirect_to my_registered_application
    end
  end

  describe "DELETE #destroy" do
    it "decreases the number of registered_applications by 1" do
      sign_in my_user
      delete :destroy, id: my_registered_application.id
      count = RegisteredApplication.all.size
      expect(count).to eq(0)
    end

    it "deletes the registered_application" do
      sign_in my_user
      delete :destroy, id: my_registered_application.id
      count = RegisteredApplication.where({id: my_registered_application.id}).size
      expect(count).to eq(0)
    end

    it "redirects to the registered_application index" do
      sign_in my_user
      delete :destroy, id: my_registered_application.id
      expect(response).to redirect_to(registered_applications_path)
    end
  end

end
