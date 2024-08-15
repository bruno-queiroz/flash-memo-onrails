FactoryBot.define do
  factory :user do
    name { 'John' }
    encrypted_password { 'Doe' }
  end
end
