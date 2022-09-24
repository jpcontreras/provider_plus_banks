require 'rails_helper'

RSpec.describe Provider, type: :model do
  subject { FactoryBot.create(:provider) }

  # Validations
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a contact name" do
      subject.contact_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a nit valid format" do
      subject.nit = Faker::Number.number(digits: 11)
      expect(subject).to_not be_valid
    end

    it "is not valid without a contact cellphone length" do
      subject.contact_cellphone = Faker::Number.number(digits: 11)
      expect(subject).to_not be_valid
    end

    it "is not valid without a contact number length" do
      subject.contact_cellphone = Faker::Number.number(digits: 16)
      expect(subject).to_not be_valid
    end
  end

  # Associations
  describe "Associations" do
    it "belongs to bank" do
      assc = described_class.reflect_on_association(:bank)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
