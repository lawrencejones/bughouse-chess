FactoryGirl.define do
  factory :user do
    name     "Karolis Kemeraitis"
    email    "karolis.k@gmail.com"
    password "slapukas"
    password_confirmation "slapukas"
  end
end