class QuizzesController < ApplicationController
  before_filter :authenticate_teacher!
  before_filter :set_timezone

  def set_timezone
    Time.zone = current_teacher.school.time_zone
  end

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = current_teacher.quizzes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quizzes }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if !current_teacher.quizzes.include? @quiz
        flash[:notice] = "You are not authorized to view that quiz."
        format.html { redirect_to quizzes_path }
      else
        format.html # show.html.erb
      end      
    end

  end

  # GET /quizzes/new
  # GET /quizzes/new.json
  def new
    @quiz = Quiz.new
    @quiz.questions.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
    
    respond_to do |format|
      if !current_teacher.quizzes.include? @quiz
        flash[:notice] = "You are not authorized to edit that quiz."
        format.html { redirect_to quizzes_path }
      else
        if @quiz.published
          redirect_to quizzes_path
          flash[:notice] = "You cant edit a published quiz. Try re-publishing it. Old quiz will be lost!"
        else
          format.html # edit.html.erb
        end
      end      
    end

  end

  # GET /quizzes/1/republish
  def republish
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if !current_teacher.quizzes.include? @quiz
        flash[:notice] = "You are not authorized to republish that quiz."
        format.html { redirect_to quizzes_path }
      else
        format.html # republish.html.erb
      end      
    end

  end

  def increment
    @quiz = Quiz.find(params[:id])
    @quiz.ocurrences += 1

    respond_to do |format|
      if @quiz.save
        flash[:notice] = "Max. attempts incremented."
        format.html {redirect_to quizzes_path}
      else
        flash[:notice] = "Error incrementing max attempts. Try again."
        format.html {redirect_to quizzes_path}
      end
    end

  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new(params[:quiz])
    @quiz.teacher = current_teacher
    
    if !params[:old_quiz_id].nil?
      @old_quiz = Quiz.find(params[:old_quiz_id])
      @old_quiz.destroy
    end

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.json
  def update
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if !current_teacher.quizzes.include? @quiz
        flash[:notice] = "You are not authorized to edit that quiz."
        format.html { redirect_to quizzes_path }
      else
        if @quiz.published
          flash[:notice] = "You cant edit a published quiz. Try re-publishing it. Old quiz will be lost!"
          format.html { redirect_to quizzes_path }
        else
          if @quiz.update_attributes(params[:quiz])
            format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
          else
            format.html { render action: "edit" }
          end
        end
      end      
    end

  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if !current_teacher.quizzes.include? @quiz
        flash[:notice] = "You are not authorized to destroy that quiz."
        format.html { redirect_to quizzes_path }
      else
        @quiz.destroy
        format.html { redirect_to quizzes_url }
      end      
    end

  end

end
