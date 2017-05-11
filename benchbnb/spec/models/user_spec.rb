require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(username: 'test2', password: 'password') }
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it "should have a unique name" do
      User.create(username: 'test', password: 'password')
      should validate_uniqueness_of(:username)
    end

    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it do
      should validate_length_of(:password).is_at_least(6).on(:create)
    end
  end

  describe 'associations' do
    it { should have_many(:favorites) }
    it { should have_many(:favorite_benches) }
  end

  describe 'model_methods' do
    describe '.find_by_credentials' do

      context 'when given correct credentials' do
        it 'should find the right user' do
          correct_user = User.find_by_credentials('test2', 'password')
          expect(correct_user).to eq(user)
        end
      end

      context 'when given incorrect credentials' do
        it 'should return nil' do
          incorrect_user = User.find_by_credentials('test3', 'password')
          expect(incorrect_user).to eq(nil)
        end
      end
    end
  end

  describe 'instance_methods' do
    describe '#reset_session_token!' do
      it 'resets the session token' do
        old_session_token = user.session_token
        user.reset_session_token!
        expect(old_session_token).not_to eq(user.session_token)
      end
    end
  end
end
