class ClassroomsController < ApplicationController
  before_filter :authenticate_admin!

  # GET /classrooms
  # GET /classrooms.json
  def index
    @classrooms = current_admin.school.classrooms

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      if !current_admin.school.classrooms.include? @classroom
        flash[:notice] = "You are not authorized to view that classroom."
        format.html { redirect_to classrooms_path }
      else
        format.html # show.html.erb     
      end
    end
  end

  # GET /classrooms/new
  # GET /classrooms/new.json
  def new
    @classroom = Classroom.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /classrooms/1/edit
  def edit
    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      if !current_admin.school.classrooms.include? @classroom
        flash[:notice] = "You are not authorized to edit that classroom."
        format.html { redirect_to classrooms_path }
      else
        format.html # edit.html.erb     
      end
    end

  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(params[:classroom])
    @classroom.school = current_admin.school
    
    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /classrooms/1
  # PUT /classrooms/1.json
  def update
    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      if !current_admin.school.classrooms.include? @classroom
        flash[:notice] = "You are not authorized to update that classroom."
        format.html { redirect_to classrooms_path }
      else
        if @classroom.update_attributes(params[:classroom])
          format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        else
          format.html { render action: "edit" }
        end   
      end
    end

  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      if !current_admin.school.classrooms.include? @classroom
        flash[:notice] = "You are not authorized to destroy that classroom."
        format.html { redirect_to classrooms_path }
      else
        @classroom.destroy
        format.html { redirect_to classrooms_url }  
      end
    end
    
  end
end
