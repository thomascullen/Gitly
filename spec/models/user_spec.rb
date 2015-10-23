require 'rails_helper'

describe User, type: :model do
  let!(:user) { FactoryGirl.create :user }
  let!(:category) { FactoryGirl.create :category }
  let!(:project) { FactoryGirl.create :project, category: category }

  it { should have_many :subscriptions }
  it { should have_many(:categories).through(:subscriptions) }

  describe '#has_updates?' do
    it 'returns true if there are projects in the users categories' do
      FactoryGirl.create :subscription, user: user, category: category
      expect(user.has_updates?).to be_truthy
    end

    it 'returns false if there are no projects in the users categories' do
      expect(user.has_updates?).to be_falsey
    end
  end
end
