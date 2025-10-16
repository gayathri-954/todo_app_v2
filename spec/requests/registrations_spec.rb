require 'rails_helper'

RSpec.describe "User registration", type: :request do
  describe "POST /users" do
    it "registers a new user with valid details" do
      post user_registration_path, params: {
        user: {
          email: "newuser@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }

      # Devise redirects (302 or 303) after successful signup
      expect(response).to have_http_status(:found).or have_http_status(:see_other)

      follow_redirect!
      expect(response.body).to include("Welcome! You have signed up successfully").or include("Todo")
    end

    it "does not register a user with invalid details" do
      post user_registration_path, params: {
        user: {
          email: "invalid_email",
          password: "123",
          password_confirmation: "456"
        }
      }

      expect(response).to have_http_status(:unprocessable_entity).or have_http_status(:ok)
      expect(response.body).to include("Email is invalid").or include("Password confirmation doesn't match")
    end
  end
end
