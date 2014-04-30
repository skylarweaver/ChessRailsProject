json.array!(@camps) do |camp|
  json.extract! camp, :id, :curriculum_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active
  json.url camp_url(camp, format: :json)
end
