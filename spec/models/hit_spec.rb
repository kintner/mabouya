require 'spec_helper'

describe Hit do
  describe "hash" do
    it "calulcates correctly" do
      contact = FactoryGirl.build(:hit)
      expect(contact.calculate_hash).to eq(contact[:hash])
    end

    it "ignores empty attributes" do
      contact = FactoryGirl.build(:hit_without_referrer)
      expect(contact.calculate_hash).to eq(contact[:hash])
    end

  end
end
