
FactoryGirl.define do
  factory :user do
    ignore do
      is_confirmed true
    end
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    sequence(:nickname) {|n| "nickname_#{n}"}
    notify false
    password 'foobar'
    password_confirmation 'foobar'
    password_reset_token 'qiM6TjrqAKmEMqybM4-tvg'
    password_reset_sent_at Time.zone.now
    confirmed_at { is_confirmed ? Time.zone.now : nil }

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end
