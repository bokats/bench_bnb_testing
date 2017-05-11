require 'rails_helper'

RSpec.describe User, type: :model do
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
      let!(:user) { User.create(username: 'test2', password: 'password') }
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
end
