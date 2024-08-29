module FmtUtl
#  Formatting utilities.

# require('./config/popps_defs');
#const crypto = require('crypto');
#var nJwt     = require('njwt');


#/**
# *  @function left0pad() returns a string representation of number left padded with zeros.
# */
def FmtUtl.left0pad(num, size) 
  s = num.to_s
  while (s.length < size) do
    s = "0" + s
  end
  return s;
end


#/**
# * @function tm_now() returns current time formatted as string.
# */
def FmtUtl.tm_now() 
  dt = Time.now
  h = dt.hour
  m = dt.min
  s = dt.sec
  ms = dt.usec.div(1000)
  tm_str = left0pad(h,2) + ':' + left0pad(m,2) + ':' + left0pad(s,2) + ':' + left0pad(ms,3)
  return tm_str;
end

  
#/**
# * dt_tm_string function returns a formatted date-time.
# */
def FmtUtl.dt_tm_string(dtm) 
  dt = Time.at(dtm.to_i)
  yyyy = left0pad(dt.year,4)
  mon = left0pad(dt.month,2)
  dd = left0pad(dt.day,2)
  hh = left0pad(dt.hour,2)
  mm = left0pad(dt.min,2)
  ss = left0pad(dt.sec,2)
  dt_str = yyyy + ", " + mon + " " + dd + " " + hh + ":" + mm + ":" + ss;
  return dt_str;
end


#/**
# * @function approx_age returns current approximate age.
# *  return  - integer value of age.
# */
def FmtUtl.approx_age(age_signup, date_signup) 
  curr_utc = Time.now.gmtime
  signup_utc = date_signup.getutc
  return (curr_utc.year - signup_utc.year + age_signup)
end


#/**
# * @function signup_age function returns age at signup date.
# *  current_age - approx age from user input form.
# *  date_signup -  date the user signed up for an account.
# *  return - integer value of age at signup.
# */
def FmtUtl.signup_age(current_age, date_signup) 
  curr_utc = Time.now.gmtime
  signup_utc = date_signup.getutc
  return ( current_age - (curr_utc.year - signup_utc.year) )
end


#/**
# * err_compose function returns an error hash.
# */
def FmtUtl.err_compose(err_base, err_msg) 
  error_object = err_base
  error_object[:error_msg] = err_msg
  return error_object
end


#### Note: the following are supported elsewhere in Rails -- not ported from "sonic_node_host" project
####       UATs built & checked in Devise
####       RRTs built & checked in ../controlers/api/concerns/refreshable_auth.rb
# * @function <b>uat_encrypt</b> - function returns encrypted User_id.
# * @function <b>uat_decrypt</b> - function returns plain-text User_id.
# * @function <b>rrt_encrypt</b> - function returns encrypted {user_id, device_guid} JSON object.
# * @function <b>rrt_sub_decrypt</b> - function returns decrypted JSON {user_id: user_id, device_guid: device_guid }.
# * local utility function encrypt_str(plain_str) 
# * local utility function decrypt_str(encrypted_str) 
# * @function gen_uat_jwt - constructs a UserAuthToken from UserId, NickName and <tbd> Role.
# * @function gen_rrt_jwt - constructs a RelayRegToken from UserId and DeviceGuid.

end

