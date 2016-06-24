class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def require_login
  	redirect_to '/sessions/new' if session[:user_id] == nil
  end
  def require_current_lender  
    if session[:user_type] = 'lender'
      current_lender = Lender.find(session[:user_id])
      lender = Lender.find(params[:id])
      redirect_to "/lenders/#{current_lender.id}" if current_lender != lender
    end
  end
  def require_current_borrower
    if session[:user_type] = 'borrower'
      current_borrower = Borrower.find(session[:user_id])
      borrower = Borrower.find(params[:id])
      redirect_to "/borrowers/#{current_borrower.id}" if current_borrower != borrower
    end
  end
end
