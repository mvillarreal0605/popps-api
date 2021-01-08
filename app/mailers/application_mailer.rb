class ApplicationMailer < ActionMailer::Base
  default from: 'hello@playprecise.com.com'
  layout 'mailer'
  add_template_helper(EmailHelper)
end
