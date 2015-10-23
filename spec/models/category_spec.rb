require 'rails_helper'

describe Category, type: :model do
  it { should have_many :subscriptions }
  it { should have_many(:users).through(:subscriptions) }
  it { should have_many :projects }
end
