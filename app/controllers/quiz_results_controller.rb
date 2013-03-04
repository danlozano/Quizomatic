class QuizResultsController < ApplicationController
  before_filter :authenticate_student!, :except => [:show]
  before_filter :set_timezone, :except => [:show]

  before_filter :authenticate_users, :only => [:show]
  before_filter :set_timezone_multi, :only => [:show]

  def set_timezone
    Time.zone = current_student.school.time_zone
  end

  def set_timezone_multi
    if @role == 'parent'
      Time.zone = current_parent.students[0].school.time_zone
    else
      Time.zone = current_user.school.time_zone
    end
  end

  def current_user
    current_teacher || current_admin || current_student
  end

  def authenticate_users
    if admin_signed_in?
      @role = 'admin'
    elsif teacher_signed_in?
      @role = 'teacher'
    elsif parent_signed_in?
      @role = 'parent'
    elsif student_signed_in?
      @role = 'student'
    else
      flash[:notice] = "Please log-in first."
      redirect_to root_path
    end
  end

  def appropiate_masthead
    if @role == 'admin'
      return 'admin_dashboard/admin_masthead'
    elsif @role == 'teacher'
      return 'teacher_dashboard/teacher_masthead'
    elsif @role == 'parent'
      return 'parent_dashboard/parent_masthead'
    elsif @role == 'student'
      return 'student_dashboard/student_masthead'
    end
  end

  helper_method :appropiate_masthead

  # GET /quiz_results
  # GET /quiz_results.json
  def index
    @quiz_results = current_student.quiz_results
    @unfiltered_quizzes = current_student.classroom.teacher.quizzes
    @quizzes = Quiz.TakeableQuizzes(@unfiltered_quizzes, @quiz_results)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /quiz_results/1
  # GET /quiz_results/1.json
  def show
    @quiz_result = QuizResult.find(params[:id])

    respond_to do |format|
      if @role == 'student'
        if !current_student.quiz_results.include? @quiz_result
          flash[:notice] = "You are not authorized to view that quiz result."
          format.html { redirect_to quiz_results_path }
        else
          format.html # show.html.erb
        end     
      elsif @role == 'admin'
        if !current_admin.school.students.include? @quiz_result.student
          flash[:notice] = "You are not authorized to view that quiz result."
          format.html { redirect_to show_students_path }
        else
          format.html # show.html.erb
        end
      elsif @role == 'teacher'
        if !current_teacher.classroom.students.include? @quiz_result.student
          flash[:notice] = "You are not authorized to view that quiz result."
          format.html { redirect_to show_students_path }
        else
          format.html # show.html.erb
        end
      elsif @role == 'parent'
        if !current_parent.students.include? @quiz_result.student
          flash[:notice] = "You are not authorized to view that quiz result."
          format.html { redirect_to show_students_path }
        else
          format.html # show.html.erb
        end
      end
    end

  end

  # GET /quiz_results/new
  # GET /quiz_results/new.json
  def new
    @quiz_results = current_student.quiz_results
    @unfiltered_quizzes = current_student.classroom.teacher.quizzes
    @quizzes = Quiz.TakeableQuizzes(@unfiltered_quizzes, @quiz_results)

    @quiz = Quiz.find(params[:quiz_id])
    @quiz_result = QuizResult.new
    @quiz_result.question_results.build

    respond_to do |format|
      if !@quizzes.include? @quiz
        flash[:notice] = "You can't take that quiz."
        format.html { redirect_to quiz_results_path }
      else
        format.html # new.html.erb
      end
    end
  end

  # GET /quiz_results/1/edit
  def edit
    @quiz_result = QuizResult.find(params[:id])

    respond_to do |format|
      if !current_student.quiz_results.include? @quiz_result
        flash[:notice] = "You are not authorized to edit that quiz."
        format.html { redirect_to quiz_results_path }
      else
        if @quiz_result.published == false
          format.html # edit.html.erb
        else
          flash[:notice] = "You cant edit a submitted quiz! Ask your teacher if you want another chance to take the quiz."
          format.html { redirect_to quiz_results_path}
        end
      end      
    end

  end

  # POST /quiz_results
  # POST /quiz_results.json
  def create
    @quiz_result = QuizResult.new(params[:quiz_result])
    @quiz_result.student = current_student

    #If submitting.
    if @quiz_result.published
      @quiz_result.date = Time.now
      respond_to do |format|
        if @quiz_result.save
          @quiz_result.ocurrence = getOcurence @quiz_result
          @quiz_result.setGrade
          if @quiz_result.save
            format.html {redirect_to @quiz_result, notice: 'Quiz successfully answered.'}
          else
            format.html {redirect_to @quiz_result, notice: 'Error grading.'}
          end
        else
          format.html { render action: "new" }
        end
      end
      
    #If just saving, not submitting.
    else
      respond_to do |format|
        if @quiz_result.save
          format.html { redirect_to @quiz_result, notice: 'Quiz successfully saved.' }
        else
          format.html { render action: "new" }
        end
      end
    end
    
  end

  # PUT /quiz_results/1
  # PUT /quiz_results/1.json
  def update
    @quiz_result = QuizResult.find(params[:id])

    respond_to do |format|
      if @quiz_result.update_attributes(params[:quiz_result])
        if @quiz_result.published == true
          @quiz_result.date = Time.now
          @quiz_result.ocurrence = getOcurence @quiz_result
          @quiz_result.setGrade
          if @quiz_result.save
            format.html { redirect_to @quiz_result, notice: 'Quiz result was successfully answered.' }
          else
            format.html { redirect_to @quiz_result, notice: 'Error grading.' }
          end
        else
          format.html { redirect_to @quiz_result, notice: 'Quiz result was successfully saved.' }
        end
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /quiz_results/1
  # DELETE /quiz_results/1.json
  def destroy
    @quiz_result = QuizResult.find(params[:id])
    @quiz_result.destroy

    respond_to do |format|
      format.html { redirect_to quiz_results_url }
    end
  end

  private
  def getOcurence(quiz_r)
    ocurrence = 0
    quiz_results = current_student.quiz_results
    quiz_results.each do |quiz_result|
      if quiz_result.quiz_id == quiz_r.quiz_id
        ocurrence += 1
      end
    end
    ocurrence
  end

end
