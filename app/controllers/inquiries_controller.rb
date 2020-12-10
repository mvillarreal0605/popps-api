class InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save
      # InquiryMailer.inquiry_email(@inquiry).deliver_now
      # ConfirmationMailer.confirmation_email(@inquiry).deliver_now
      redirect_to root_path
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :phone_number, :email, :organization)
  end
end
