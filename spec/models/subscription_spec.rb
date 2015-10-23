require 'rails_helper'

describe Subscription, type: :model do
  it { should belong_to :user }
  it { should belong_to :category }
  it { should validate_uniqueness_of(:category_id).scoped_to(:user_id) }
end
