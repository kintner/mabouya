class StatsController < ApplicationController
  before_filter :configure_dates
  def top_urls
    render json: Hit.top_urls(@start_date, @end_date)
  end

  def top_referrers
    render json: Hit.top_referrers(@start_date, @end_date)
  end

  private

  def configure_dates
    # should show stats for the past 5 days
    @start_date = Date.today - 5
    @end_date = Date.today - 1
  end



end
