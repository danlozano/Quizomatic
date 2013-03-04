class ShowTeachersController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @teachers = current_admin.school.teachers

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @teachers }
    end
  end

  def show
  	@teacher = Teacher.find(params[:id])

    respond_to do |format|
      if !current_admin.school.teachers.include? @teacher
        flash[:notice] = "You are not authorized to view that teacher."
        format.html { redirect_to show_teachers_path }
      else
        format.html # show.html.erb        
      end
    end

  end

  def edit
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if !current_admin.school.teachers.include? @teacher
        flash[:notice] = "You are not authorized to edit that teacher."
        format.html { redirect_to show_teachers_path }
      else
        format.html # edit.html.erb        
      end
    end

  end

  def update
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if !current_admin.school.teachers.include? @teacher
        flash[:notice] = "You are not authorized to update that teacher."
        format.html { redirect_to show_teachers_path }
      else
        if @teacher.update_attributes(params[:teacher])
          flash[:notice] = "Teacher succesfully edited. "
          format.html { redirect_to show_teachers_path }
        else
          format.html { render action: "edit" }
        end        
      end
      
    end
  end

  def new
    @teacher = Teacher.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @teacher = Teacher.new(params[:teacher])
    @teacher.school = current_admin.school

    respond_to do |format|
      if @teacher.save
        flash[:notice] = "Teacher succesfully created. "
        format.html { redirect_to show_teachers_path }
      else
        format.html { render action: "new" }
      end
    end

  end

  def destroy
    @teacher = Teacher.find(params[:id])

    respond_to do |format|
      if !current_admin.school.teachers.include? @teacher
        flash[:notice] = "You are not authorized to destroy that teacher."
        format.html { redirect_to show_teachers_path }
      else
        @teacher.destroy
        format.html { redirect_to show_teachers_path }  
      end
    end

  end

end
