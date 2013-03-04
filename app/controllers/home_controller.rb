class HomeController < ApplicationController
  
  def index
  	
  	if admin_signed_in?
  			redirect_to :controller => 'admin_dashboard', :action => 'index'
    elsif teacher_signed_in?
      redirect_to :controller => 'teacher_dashboard', :action => 'index'
    elsif student_signed_in?
      redirect_to :controller => 'student_dashboard', :action => 'index'
    elsif parent_signed_in?
      redirect_to :controller => 'parent_dashboard', :action => 'index'
  	end

  end

  def login

  end

  def help

  end

  def about

  end

end
