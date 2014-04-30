json.array!(@registrations) do |registration|
  json.extract! registration, :id, :camp_id, :student_id, :payment_status, :points_earned
  json.url registration_url(registration, format: :json)
end
