class InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save
      InquiryMailer.send_confirmation(@inquiry).deliver_now
      InquiryMailer.receive_notification(@inquiry).deliver_now
      flash[:notice] = "Success: Your inquiry has been received."
      redirect_to root_path
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :phone_number, :email, :organization)
  end
end
