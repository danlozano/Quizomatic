class ShowParentsController < ApplicationController
  before_filter :authenticate_admin!
  
  def index
  	 @parents = current_admin.school.parents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parents }
    end
  end

  def show
  	 @parent = Parent.find(params[:id])

    respond_to do |format|
      if !current_admin.school.parents.include? @parent
        flash[:notice] = "You are not authorized to view that parent."
        format.html { redirect_to show_parents_path }
      else
        format.html # show.html.erb     
      end
    end
  end

  def edit
    @parent = Parent.find(params[:id])

    respond_to do |format|
      if !current_admin.school.parents.include? @parent
        flash[:notice] = "You are not authorized to edit that parent."
        format.html { redirect_to show_parents_path }
      else
        format.html # edit.html.erb     
      end
    end
  end

  def update
    @parent = Parent.find(params[:id])

    respond_to do |format|
      if !current_admin.school.parents.include? @parent
        flash[:notice] = "You are not authorized to update that parent."
        format.html { redirect_to show_parents_path }
      else
        if @parent.update_attributes(params[:parent])
          flash[:notice] = "Parent succesfully edited. "
          format.html { redirect_to show_parents_path }
        else
          format.html { render action: "edit" }
        end  
      end

    end
  end

  def destroy
    @parent = Parent.find(params[:id])

    respond_to do |format|
      if !current_admin.school.parents.include? @parent
        flash[:notice] = "You are not authorized to edit that parent."
        format.html { redirect_to show_parents_path }
      else
        @parent.destroy
        format.html { redirect_to show_parents_path }
      end  
    end

  end

end
