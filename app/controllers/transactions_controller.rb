class TransactionsController < ApplicationController
	def create
		payment = params[:amount].to_f
		lender = Lender.find(session[:user_id])
		balance = lender["balance"].to_f
		if balance - payment < 0
			flash[:errors] = "Insufficient funds."
			redirect_to :back
		else
			dupe = Transaction.find_by(borrower_id: params[:borrower_id], lender_id: session[:user_id])
			if dupe
				dupe["amount"] += payment
				dupe.save
			else
				Transaction.create(borrower_id: params[:borrower_id], lender_id: session[:user_id], amount: params[:amount])
			end
			borrower = Borrower.find(params[:borrower_id])
			if borrower["amount_received"] == nil
				borrower["amount received"] == 0.0
			end
			borrower["amount_received"] += params[:amount].to_f
			borrower.save
			lender["balance"] -= params[:amount].to_f
			lender.save
			redirect_to "/lenders/#{session[:user_id]}"
		end
	end
end
