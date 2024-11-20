module RequestSpecHelper
  def sign_in_and_set_session(user)
    # Sign in the user
    sign_in user
    # Set up proper session handling
    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session) do
      # Return a real session object instead of a mock
      @current_session ||= {}
      @current_session
    end
    # Allow session to be modified
    allow_any_instance_of(ActionDispatch::Request)
      .to receive(:session=) do |_, new_session|
      @current_session = new_session
    end
  end
end

RSpec.configure do |config|
  config.include RequestSpecHelper, type: :request
end
