class Hit < Sequel::Model

  def before_create
    set_hash
  end

  def calculate_hash
    data = values.slice(:id, :url, :referrer, :created_at).delete_if { |k,v| v.nil?}
    Digest::MD5.hexdigest(data.to_s)
  end

  def set_hash
    self.hash = calculate_hash
  end

end
