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

  # This method will truncate the hits table and regenerate it
  def self.populate_database(rows = 1000000)
    batch_size = [rows, 5000].min
    number_batches = rows / batch_size

    values = {}
    id = 0

    Hit.truncate
    number_batches.times do |batch|
      data = []
      batch_size.times do |t|

        id += 1

        # this order is important since the Digest Hash generated is dependent on the hash insertion order
        row = [id, BASE_URLS.sample, BASE_REFERRERS.sample, random_time]
        values[:id] = row[0]
        values[:url] = row[1]
        values[:referrer] = row[2]
        values[:created_at] = row[3]

        row << Hit.hash_hash(values)
        data << row
      end

      Hit.import([:id, :url, :referrer, :created_at, :hash], data)
    end

  end

  def self.random_time
    RandomTime.between(DATE_RANGE.first.to_time, DATE_RANGE.last.to_time)
  end



end
