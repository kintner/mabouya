module RandomTime

  def self.any
    n = Time.now
    between(n - 5.years, n)
  end

  def self.between(start_time, end_time)
    Time.at((end_time - start_time)*rand + start_time.to_f)
  end

end
