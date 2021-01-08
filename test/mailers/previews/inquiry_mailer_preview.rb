# Preview all emails at http://localhost:3000/rails/mailers/inquery_mailer
class InquiryMailerPreview < ActionMailer::Preview
  def send_confirmation
    inquiry = find_or_create_inquiry
    InquiryMailer.send_confirmation(inquiry)
  end

  private

  def find_or_create_inquiry
    Inquiry.last  || Inquiry.create(inquiry_params)
  end

  def inquiry_params
    {
      name: 'Coach Shepheard',
      phone_number: '913-876-4743',
      email: "inquiry@example.com",
      orginazation: 'T Bonez'
    }
  end
end
