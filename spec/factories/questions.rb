FactoryBot.define do
  factory :question do
    title {'test question 1'}
    content {'RSpecでのテスト'}
    user
  end
end
