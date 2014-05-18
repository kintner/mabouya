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

  describe ".top_urls" do
    date = Hit.first.date
    report = Hit.top_urls(date, date)
    it "returns a hash with date keys" do
      expect(report).to be_an_instance_of(Hash)
      expect(report.keys.uniq.size).to eq(1)
      expect(report.keys.uniq.first).to eq(date)
    end

    it "returns a hash with array keys" do
      record = report[date]
      expect(record).to be_an_instance_of(Array)
      record.each do |row|
        expect(row).to be_an_instance_of(Hash)
        expect(row[:url]).to be_an_instance_of(String)
        expect(row[:visits]).to be > 0
      end
    end
  end


  describe ".top_referrers" do
    date = Hit.first.date
    report = Hit.top_referrers(date, date)
    it "returns a hash with date keys" do
      expect(report).to be_an_instance_of(Hash)
      expect(report.keys.uniq.size).to eq(1)
      expect(report.keys.uniq.first).to eq(date)
    end

    it "returns a hash with array keys" do
      record = report[date]
      expect(record).to be_an_instance_of(Array)
      record.each do |row|
        expect(row).to be_an_instance_of(Hash)
        expect(row[:url]).to be_an_instance_of(String)
        expect(row[:visits]).to be >= 0

        expect(row[:referrers]).to be_an_instance_of(Array)
        row[:referrers].each do |ref|
          expect(ref[:url]).to be_an_instance_of(String) unless ref[:url].nil?
          expect(ref[:visits]).to be >= 0
        end
      end
    end

  end
end
