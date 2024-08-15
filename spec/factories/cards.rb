FactoryBot.define do
  factory :card do
		front {"front"}
		back {"back"}
		is_reset {false}
		review_at {Time.utc(1970)}
		ease_factor {1.0}
		interval {3}
		repetitions {1}
  end
end