class Hit < Sequel::Model

  def after_create
    set_hash
  end

  # The hash spec:
  #
  # The MD5 hexdigest of a hash containing the aforementioned columns, modulo those whose value is null.
  # Example:
  # `Digest::MD5.hexdigest({id:1, url: 'http://apple.com', referrer: 'http://store.apple.com/us', created_at: Time.parse('2012-01-01')}.to_s)`

  # This is unfortunate for a couple of reasons:
  # 1. The hash depends on the primary key so we can't precalculate the hash before we save therefore adding an additional database call when inserting a hit
  # 2. The hash assumes an ordered hash which with Ruby 1.9 is safe but still a little sketchy. Not sure how this is better then just hashing an array of the values

  def calculate_hash
    data = values.slice(:id, :url, :referrer, :created_at).delete_if { |k,v| v.nil?}
    Digest::MD5.hexdigest(data.to_s)
  end

  def self.hash_hash(values)
    Digest::MD5.hexdigest(values.to_s)
  end

  def set_hash
    self.hash = calculate_hash
  end



  def self.top_urls(start_date = Date.new(2014,01,01), end_date = Date.new(2014,1,5))
    Hit.db["SELECT url, count(url) as visits, date FROM hits
            WHERE date BETWEEN ? and ?
            GROUP BY url, date order by date, visits", start_date, end_date].to_a


  end

  def self.top_referrers(start_date = Date.new(2014,01,01), end_date = Date.new(2014,1,5))
    top_urls = top_urls(start_date, end_date)
    result = {}
    top_urls.group_by {|x| x[:date]}.each do |date, urls|
      result[date] ||= []
      urls.sort {|x,y| x[:visits] <=> y[:visits]}[0..9].each do |url|
        referrers = Hit.db["SELECT referrer, count(referrer) as visits from hits where date = ? and url = ? group by referrer order by count(referrer) desc limit 5", date, url[:url]].to_a.map {|row| {url: row[:referrer], visits: row[:visits]}}
        record = {url:url[:url], visits: url[:visits], referrers: referrers }
        result[date] << record
      end
    end

    result


  end


end
