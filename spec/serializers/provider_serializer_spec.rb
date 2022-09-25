require 'rails_helper'

RSpec.describe ProviderSerializer, type: :serializer do
  let(:provider) { FactoryBot.build(:provider) }
  let(:serialized_provider) { described_class.new(provider).as_json }

  subject { serialized_provider }

  it 'has an ID that matches with provider ID' do
    expect(subject[:id]).to eq(provider.id)
  end

  it 'has an name that matches with provider name' do
    expect(subject[:name]).to eq(provider.name)
  end

  it 'has an contact_name that matches with provider contact_name' do
    expect(subject[:contact_name]).to eq(provider.contact_name)
  end

  it 'has an contact_cellphone that is blank' do
    expect(subject[:contact_cellphone].nil?).to eq(true)
  end

  it 'has an bank_name that matches with provider bank_name' do
    expect(subject[:bank_name]).to eq(provider.bank_name)
  end

  it 'has an account_number that is blank' do
    expect(subject[:account_number].nil?).to eq(true)
  end
end