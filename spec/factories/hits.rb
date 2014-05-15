# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hit do |f|
    t = Time.new(2014, 2, 1, 15, 30, 45)
    f.url 'http://nytimes.com'
    f.referrer 'https://example.com'
    f.created_at t
    f.date  t.to_date
    f.id 1
    f.hash '673e95b2346af13db34f9097dec3aa10'
  end

  factory :hit_without_referrer, class: Hit do |f|
    t = Time.new(2014, 2, 1, 15, 30, 45)
    f.url 'http://cnn.com'
    f.created_at t
    f.date  t.to_date
    f.id 2
    f.hash 'ada6c170b1d82eb72be977471206ee64'
  end

end
