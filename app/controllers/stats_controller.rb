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
    @start_date, @end_date = Date.parse('2014-01-01'), Date.parse('2014-01-05')
  end



end
