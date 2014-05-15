class StatsController < ApplicationController

  def top_urls
    render json: Hit.top_urls
  end

  def top_referrers
    render json: Hit.top_referrers
  end


end
