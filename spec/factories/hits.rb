# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hit do |f|
    f.url 'http://nytimes.com'
    f.referrer 'https://example.com'
    f.created_at Time.new(2014, 1, 1, 15, 30, 45)
    f.id 1
    f.hash 'e575769d42d291085a7f30d9751589bb'
  end

  factory :hit_without_referrer, class: Hit do |f|
    f.url 'http://cnn.com'
    f.created_at Time.new(2014, 2, 1, 15, 30, 45)
    f.id 2
    f.hash 'ada6c170b1d82eb72be977471206ee64'
  end

end
