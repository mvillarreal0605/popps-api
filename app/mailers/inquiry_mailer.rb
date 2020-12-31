class InquiryMailer < ApplicationMailer
  default from: 'notifications@playprecise.com'

  def inquiry_email(inquiry)
    @inquiry = inquiry
    mail(to: 'mvillarreal0605@gmail.com', subject: 'New Inquiry for Precise Play')
  end
end
