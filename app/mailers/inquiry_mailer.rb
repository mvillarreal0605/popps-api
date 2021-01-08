class InquiryMailer < ApplicationMailer
  default from: 'notifications@playprecise.com'

  def send_confirmation(inquiry)
    mail(to: inquiry.email, from: 'hello@playprecise.com', subject: 'Hello, from Precise Play')
  end

  def receive_notification(inquiry)
    @inquiry = inquiry
    mail(to: 'michael@bellhour.com', from: 'notifications@playpreciese.com', subject: 'New Inquiry for Precise Play')
  end
end
