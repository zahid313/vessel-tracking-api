json.extract! voyage, :id, :from_place, :to_place, :start_at, :end_at, :vessel_id, :created_at, :updated_at
json.vessel do
    json.partial! 'api/vessels/vessel', vessel: voyage.vessel
end

