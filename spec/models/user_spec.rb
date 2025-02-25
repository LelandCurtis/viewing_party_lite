require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }

    it "doesn't store passwords improperly" do
      user = create(:user, password: 'password', password_confirmation: 'password')
      expect(user).to_not have_attribute(:password)
      expect(user).to_not have_attribute(:password_confirmation)
      expect(user.password_digest).to_not eq('password')
    end
  end

  describe 'instance methods' do
    describe '#host_parties' do
      it "returns all the viewing parties that the user is hosting" do
        user = create(:user)
        party_1 = create(:party_with_viewers, host: user, viewer_count: 3)
        party_2 = create(:party_with_viewers, host: user, viewer_count: 5)
        party_3 = create(:party_with_viewers, viewer_count: 4)

        expect(user.host_parties).to eq([party_1, party_2])
      end
    end

    describe '#viewer_parties' do
      it "returns all the viewing parties that the user is viewing but not hosting" do
        user_1 = create(:user)
        user_2 = create(:user)
        user_3 = create(:user)

        party_1 = create(:party_with_viewers, host: user_1, viewer_count: 3)
        party_2 = create(:party_with_viewers, viewers: [user_1, user_3])
        party_3 = create(:party_with_viewers, viewers: [user_1, user_2, user_3])
        party_4 = create(:party_with_viewers, viewers: [user_2, user_3])

        expect(user_1.viewer_parties).to eq([party_2, party_3])
      end
    end
  end

  describe 'class methods' do
    describe '.not_hosts' do
      it "returns all the users but the passed user_id" do
        user_1 = create(:user, name: 'Abby')
        user_2 = create(:user, name: 'Bob')
        user_3 = create(:user, name: 'Christy')
        user_4 = create(:user, name: 'Dave')

        expect(User.not_host(user_2.id)).to eq([user_1, user_3, user_4])
      end
    end

    describe 'find_by_email' do
      it "returns the user who matches the given email" do
        user_1 = create(:user, email: "user_1@email.com")
        user_2 = create(:user, email: "user123135@email.com")
        user_3 = create(:user, email: "user1231231@email.com")

        expect(User.find_by_email("user_1@email.com")).to eq(user_1)
        expect(User.find_by_email("user1231231@email.com")).to eq(user_3)
      end
    end
  end
end
