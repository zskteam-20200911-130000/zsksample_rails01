require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: user_name, email: user_email) }
  let(:user_name) { 'test_user' }
  let(:user_email) { 'test_user@test.com' }

  describe 'test_user' do
    it { expect(user).to be_valid }
  end

  describe 'validation' do
    before { user.valid? }

    context 'without a name' do
      let(:user_name) { '' }

      it { expect(user.errors[:name]).to include("can't be blank") }
    end

    context 'without a email' do
      let(:user_email) { '' }

      it { expect(user.errors[:email]).to include("can't be blank") }
    end
  end
end
