class SessionsController < ApplicationController
	def new
		session[:user_id] == nil
	end
	def create
		if ! params[:type]
			flash[:errors] = "User Type must be selected."
			redirect_to '/sessions/new'
		else
			if params[:type] == 'Borrower'
				borrower = Borrower.find_by(email: params[:email])
				if borrower && borrower.authenticate(params[:password])
					session[:user_id] = borrower.id
					session[:user_type] = 'borrower'
					redirect_to "/borrowers/#{borrower.id}"
				else
					flash[:errors] = "Invalid Credentials."
					redirect_to '/sessions/new'
				end
			elsif params[:type] == 'Lender'
				lender = Lender.find_by(email: params[:email])
				if lender and lender.authenticate(params[:password])
					session[:user_id] = lender.id
					session[:user_type] = 'lender'
					redirect_to "/lenders/#{lender.id}"
				else
					flash[:errors] = "Invalid Credentials."
					redirect_to '/sessions/new'
				end
			else
				flash[:errors] = "User Type must be selected."
				redirect_to '/sessions/new'
			end
		end
	end

	def destroy
		reset_session
		redirect_to '/sessions/new'
	end

end
