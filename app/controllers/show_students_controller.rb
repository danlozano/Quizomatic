class ShowStudentsController < ApplicationController
  before_filter :authenticate_users
  before_filter :set_timezone

  def authenticate_users
    if admin_signed_in?
      @role = 'admin'
    elsif teacher_signed_in?
      @role = 'teacher'
    elsif parent_signed_in?
      @role = 'parent'
    else
      flash[:notice] = "Please log-in first."
      redirect_to root_path
    end
  end

  def current_user
    current_admin || current_teacher || current_parent
  end

  def appropiate_masthead
    if @role == 'admin'
      return 'admin_dashboard/admin_masthead'
    elsif @role == 'teacher'
      return 'teacher_dashboard/teacher_masthead'
    elsif @role == 'parent'
      return 'parent_dashboard/parent_masthead'
    end
  end

  def set_timezone
    if @role == 'parent'
      Time.zone = current_parent.students[0].school.time_zone
    else
      Time.zone = current_user.school.time_zone
    end
  end

  helper_method :current_user
  helper_method :appropiate_masthead
  
  def index
    if @role == 'admin'
      @students = current_admin.school.students
    elsif @role == 'teacher'
      if !current_teacher.classroom.nil?
        @students = current_teacher.classroom.students
      else
        @students = []
      end
    elsif @role == 'parent'
      @students = current_parent.students
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
  	@student = Student.find(params[:id])

    if @role == 'admin'
      students = current_admin.school.students
    elsif @role == 'teacher'
      students = current_teacher.classroom.students
    elsif @role == 'parent'
      students = current_parent.students
    end

    respond_to do |format|
      if !students.include? @student
        flash[:notice] = "You are not authorized to view that student."
        format.html { redirect_to show_students_path }
      else
        format.html # show.html.erb        
      end
    end

  end

  def edit
    @student = Student.find(params[:id])

    if @role == 'admin'
      students = current_admin.school.students
    elsif @role == 'teacher'
      students = current_teacher.classroom.students
    elsif @role == 'parent'
      students = []
    end

    respond_to do |format|
      if !students.include? @student
        flash[:notice] = "You are not authorized to edit that student."
        format.html { redirect_to show_students_path }
      else
        format.html # edit.html.erb        
      end
    end

  end

  def update
    @student = Student.find(params[:id])

    if @role == 'admin'
      students = current_admin.school.students
    elsif @role == 'teacher'
      students = current_teacher.classroom.students
    elsif @role == 'parent'
      students = []
    end

    respond_to do |format|
      if !students.include? @student
        flash[:notice] = "You are not authorized to update that student."
        format.html { redirect_to show_students_path }
      else
        if @student.update_attributes(params[:student])
          flash[:notice] = "Student succesfully edited. "
          format.html { redirect_to show_students_path }
        else
          format.html { render action: "edit" }
        end  
      end
    end

  end

  def new
    @student = Student.new
    2.times { @student.parents.build }

    respond_to do |format|
      if @role == 'parent'
        flash[:notice] = "You are not authorized to create a student."
        format.html { redirect_to show_students_path }
      else
        format.html # new.html.erb
      end
    end
  end

  def create
    @student = Student.new(params[:student])
    @student.school = current_user.school
    
    if @role == 'teacher'
      @student.classroom = current_teacher.classroom
    end

    respond_to do |format|
      if @role == 'parent'
        flash[:notice] = "You are not authorized to create a student."
        format.html { redirect_to show_students_path }
      else
        if @student.save
          flash[:notice] = "Student succesfully created. "
          format.html { redirect_to show_students_path }
        else
          format.html { render action: "new" }
        end
      end
    end

  end

  def destroy
    @student = Student.find(params[:id])

    if @role == 'admin'
      students = current_admin.school.students
    elsif @role == 'teacher'
      students = current_teacher.classroom.students
    elsif @role == 'parent'
      students = []
    end

    respond_to do |format|
      if !students.include? @student
        flash[:notice] = "You are not authorized to destroy that student."
        format.html { redirect_to show_students_path }
      else
        @student.destroy
        format.html { redirect_to show_students_path }       
      end
    end

  end

end
