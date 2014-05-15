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

end
