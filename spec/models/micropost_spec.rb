require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { User.create(name: 'test_user', email: 'test@test.com') }
  let(:micropost) { Micropost.new(content: content, user_id: user.id) }
  let(:content) { 'test text' }

  describe 'test' do
    it { expect(user).to be_valid }
  end

  describe 'content' do
    before { micropost.valid? }

    context 'with 140 words or lower' do
      let(:content) { 'a' * 140 }

      it { expect(user).to be_valid }
    end

    context 'with more than 140 words' do
      let(:content) { 'a' * 241 }

      it { expect(micropost.errors[:content]).to include('is too long (maximum is 140 characters)') }
    end
  end
end
