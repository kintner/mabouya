class HitPopulator
 DATE_RANGE = (Date.parse('2014-01-01')..Date.parse('2014-01-10')).to_a

 BASE_URLS = ['http://apple.com',
             'https://apple.com',
             'https://www.apple.com',
             'http://developer.apple.com',
             'http://en.wikipedia.org',
             'http://opensource.org']

  BASE_REFERRERS = ['http://apple.com',
                    'https://apple.com',
                    'https://www.apple.com',
                    'http://developer.apple.com',
                    nil]

  def self.populate_database(rows = 1000)
    Hit.db.transaction do
      rows.times do
        time =
        Hit.new(url: BASE_URLS.sample, referrer: BASE_REFERRERS.sample, created_at: random_time).save
      end
    end

  end

  def self.random_time
    RandomTime.between(DATE_RANGE.first.to_time, DATE_RANGE.last.to_time)
  end



end
