module POPPS
  HTTP_OK = "200"
  HTTP_Created = "201"
  HTTP_BadRequest = "400"
  HTTP_Unauthorized = "401"
  HTTP_NotFound = "404"
  HTTP_InternalServerError  = "500"
  HTTP_NotImplemented = "501"
  MustBeUnique =        {"error_code": "01", "error_msg": ""}
  MissingField =        {"error_code": "02", "error_msg": ""}
  InvalidCredentials =  {"error_code": "03", "error_msg": ""}
  InvalidState =        {"error_code": "04", "error_msg": ""}
  InvalidToken =        {"error_code": "05", "error_msg": ""}
  ServerError  =        {"error_code": "06", "error_msg": ""}
  POPPS_APP = "https//popps.com"
  WebTitle  = "Popps"
  WebVersn  = "v0.4.6 (13Jan2020)"
end

