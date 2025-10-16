require 'rails_helper'

RSpec.describe "User logout", type: :request do
  let(:user) { User.create(email: "logout_user@example.com", password: "password123") }

  before do
    # Log in user first
    post user_session_path, params: {
      user: { email: user.email, password: "password123" }
    }
    follow_redirect!
    expect(response).to have_http_status(:ok)
  end

  describe "DELETE /users/sign_out" do
    it "logs the user out successfully" do
      delete destroy_user_session_path

      # Devise redirects after logout
      expect(response).to have_http_status(:found).or have_http_status(:see_other)

      follow_redirect!

      # The redirect path could vary depending on Devise configuration
      expect(request.path).to match(/(sign_in|unauthenticated|root)/)

      # Verify Devise session cleared
      expect(session["warden.user.user.key"]).to be_nil
    end
  end
end
