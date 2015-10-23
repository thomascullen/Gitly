require 'rails_helper'

describe Project, type: :model do
  it { should belong_to :category }
end
