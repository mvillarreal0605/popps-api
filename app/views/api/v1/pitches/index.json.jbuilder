json.array! @pitches do |pitch|
  json.extract! pitch, :id, :x, :y, :s, :is_strike, :sign, :session_id 
end
