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
