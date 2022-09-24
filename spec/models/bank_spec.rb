require 'rails_helper'

RSpec.describe Bank, type: :model do
  subject { Bank.new(name: 'Davivienda') }

  # Validations
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  # Associations
  describe "Associations" do
    it "has many providers" do
      assc = described_class.reflect_on_association(:providers)
      expect(assc.macro).to eq :has_many
    end
  end

end
