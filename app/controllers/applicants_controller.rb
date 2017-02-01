class ApplicantsController < ApplicationController
  before_action :require_login, only: [:edit, :background, :authorize, :confirm]
  before_action :check_authorization, only: [:background, :authorize]

  def new
    # your code here
    @applicant = Applicant.new

  end

  def create
    # your code here
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      log_in @applicant
      redirect_to background_applicants_path
    else
      @errors = print_errors(@applicant.errors)
      render "new"
    end
  end

  def update
    # your code here
    @applicant = current_applicant
    if @applicant.update(applicant_params)
      flash[:success] = "Information updated"
      log_in @applicant
      redirect_to root_path
    else
      @errors = print_errors(@applicant.errors)
      render edit_applicant_path(current_applicant)
    end
  end

  def edit
    # your code here
    @applicant = current_applicant
  end

  def background
  end

  def confirm
  end

  def authorize
    current_applicant.update_state
    redirect_to confirm_applicants_path
  end

  private
  
  def check_authorization
    if current_applicant.workflow_state == "background_check_authorized"
      redirect_to confirm_applicants_path
    end
  end

  def require_login
    !@current_user.nil?
  end

  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :region, :source, :phone, :phone_type, :over_21, :reason, :workflow_state)
  end
end
