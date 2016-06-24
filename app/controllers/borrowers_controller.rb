class BorrowersController < ApplicationController
	before_action :require_login, except: [:create, :new]
	def new
	end
	def create
		borrower = Borrower.new(borrower_params)
		borrower["amount_received"] = 0.0
		if borrower.save
			session[:user_id] = borrower.id
			redirect_to "/borrowers/#{borrower.id}"
		else
			flash[:borrowers] = borrower.errors.full_messages
			redirect_to :back
		end
	end
	def show
		@borrower = Borrower.find(params[:id])
		@transactions = @borrower.transactions.joins(:lender).select("*")
	end

	private
		def borrower_params
			params.require(:borrower).permit(:first_name, :last_name, :email, :amount_needed, :reason, :description, :password, :password_confirmation)
		end
end