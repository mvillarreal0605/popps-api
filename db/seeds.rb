user_ids = ["1", "2", "3", "4", "5", "6","7", "8", "9", "10"]

5.times do
  UserRelayRegistration.create!({
    user_id: user_ids.sample,
    device_guid: "test_guid",
    device_description: "this is a test description",
    usage_count: [1..50].sample,
    create_time: Time.zone.now,
    update_time: Time.zone.now
  })
end

user_id = 1
pin = 1234

5.times do
  User.create!({
    user_id: "#{user_id}",
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    nick_name:  Faker::Internet.username,
    email:  "user#{user_id}@popps.com",
    cell_number: "816-555-5555",
    passwd_hash: "P@ssw0rd",
    pin: pin,
    age_at_signup: 15,
    date_of_signup: Time.zone.now,
    admin_flg: false,
    create_time: Time.zone.now,
    update_time:Time.zone.now,
    password: :passwd_hash
  })
  user_id += 1
  pin += 1
end

7.times do
  Session.create!({
    relay_device_guid: "test RDV",
    relay_description: "test relay description",
    pitch_analyzer: "test analyzer",
    description: "test description",
    current_session: [true, false].sample,
    start_time: Time.zone.now,
    pitcher_id: "#{[1..User.count].sample}",
    create_time: Time.zone.now,
    update_time: Time.zone.now
  })
end

25.times do
 Pitch.create!({
  pitch_time: Time.zone.now,
  x: 3,
  y: 3,
  s: 3,
  is_strike: [true, false].sample,
  sign: "sign",
  session_id: 5,
  create_time: Time.zone.now,
  update_time: Time.zone.now
 })
end
