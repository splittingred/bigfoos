module BigFoos
  module SpecHelpers
    def create_and_sign_in_user
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
    end
  end
end

RSpec.configure do |c|
  c.include BigFoos::SpecHelpers
end
