module RefreshableAuth
 extend ActiveSupport::Concern



  # Construct a New JWT for User Relay Registration - RRT
  # Claims consist of:
  #   iss: https://popps.com"
  #   sub: ...encrypted user_id and device_guid Hash
  #   popps_type: "rrt"
  #
  # Note: the expiration claim is OPTIONAL - leave it out for perpetual JWT.

  def new_rrt_jwt(id, guid)

    sub_hash = { user_id: id, device_guid: guid }
    sub_tos = sub_hash.to_s
    
    enc_sub = encrypt sub_tos

    payload = { iss: "https://popps.com", sub: enc_sub, popps_type: "rrt" }
    hmac_secret = Rails.application.secrets.secret_key_base
    token = JWT.encode payload, hmac_secret, 'HS256'
  end


  # De-construct the RRT JWT and check for valid format...
  # Returns a struct - {status: T/F, payload (optional)}
  # Claims payload consists of:
  #   iss: https://popps.com"
  #   sub: ...encrypted user_id and device_guid Hash
  #   popps_type: "rrt"
  #
  # Note: the expiration claim is OPTIONAL - leave it out for perpetual JWT.

  def check_rrt_jwt(token)

    hmac_secret = Rails.application.secrets.secret_key_base

    begin 
      payload = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
    rescue JWT::DecodeError
      return {status: false, err_type: "JWT::DecodeError"}
    end
    
    # Note: payload is a 2 entry array - [claims, {"alg"=>"HS256}]
    claims = payload[0]

    if (claims["iss"] != "https://popps.com" || claims["popps_type"] != "rrt")
      # invalid iss or popps_type
      return {status: false, err_type: "Invalid Claims"}
    end

    dec_sub = decrypt claims["sub"]

    payload_hsh1 = eval(dec_sub)

    uid = payload_hsh1[:user_id]
    gid = payload_hsh1[:device_guid]
  
    {status: true, user_id: uid, device_guid: gid }

  end


  private

  def encrypt text
    text = text.to_s unless text.is_a? String

    len   = ActiveSupport::MessageEncryptor.key_len
    salt  = SecureRandom.hex len
    key   = ActiveSupport::KeyGenerator.new(
            Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    encrypted_data = crypt.encrypt_and_sign text
    "#{salt}$$#{encrypted_data}"
  end

  def decrypt text
    salt, data = text.split "$$"

    len   = ActiveSupport::MessageEncryptor.key_len
    key   = ActiveSupport::KeyGenerator.new(
            Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    crypt.decrypt_and_verify data
  end

end

