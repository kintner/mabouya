require 'spec_helper'

describe StatsController do
  describe "GET top_urls" do
    it "should be json" do
      get :top_urls
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')
    end

    it "should have 5 days of data" do
      get :top_urls
      res = JSON.parse(response.body)
      expect(res.keys.size).to eq(5)
    end

  end


  describe "GET top_referrers" do
    it "should be json" do
      get :top_referrers
      expect(response.status).to eq(200)
      expect(response.content_type).to eq('application/json')
    end

    it "should have 5 days of data" do
      get :top_referrers
      res = JSON.parse(response.body)
      expect(res.keys.size).to eq(5)
    end

  end

end
