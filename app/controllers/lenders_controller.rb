class LendersController < ApplicationController
	before_action :require_login, except: [:create]
	before_action :require_current_lender, only: [:show]
	def create
		lender = Lender.new(lender_params)
		lender["balance"] = params[:balance].to_f
		if lender.save
			session[:user_id] = lender.id
			session[:user_type] = 'lender'
			redirect_to "/lenders/#{lender.id}"
		else
			flash[:lenders] = lender.errors
			redirect_to :back
		end
	end
	def show
		@lender = Lender.find(params[:id])
		@borrowers = Borrower.all
		@transactions = @lender.transactions.joins(:borrower).select("*")
	end

	private
		def lender_params
			params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
end
