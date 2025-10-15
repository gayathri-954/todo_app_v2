require 'rails_helper'

RSpec.describe "User login", type: :request do
  let(:user) { User.create(email: "test@example.com", password: "password123") }

  describe "POST /users/sign_in" do
    it "logs the user in with valid credentials" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: "password123"
        }
      }

      expect(response).to have_http_status(:found) # 302 redirect
      expect(controller.current_user).to eq(user)
    end

    it "does not log in with invalid credentials" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: "wrongpassword"
        }
      }

      expect(response).to have_http_status(:unprocessable_entity).or have_http_status(:ok)
      expect(controller.current_user).to be_nil
    end
  end
end
