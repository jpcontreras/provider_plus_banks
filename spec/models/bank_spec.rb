require 'rails_helper'

RSpec.describe Bank, type: :model do
  subject { Bank.new(name: 'Davivienda') }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
