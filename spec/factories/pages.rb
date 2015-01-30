FactoryGirl.define do
  factory :page do
    slug { Faker::Internet.slug }
    priority { Random.rand(50) }
    enabled true

    # association :parent, :factory => :page, :default => nil
    parent_id nil
  end
end