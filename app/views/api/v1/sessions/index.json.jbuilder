json.array! @sessions do |session|
  json.extract! session, :id, :relay_device_guid, :relay_description, :pitch_analyzer, :description, :current_session, :pitcher_id 
end
