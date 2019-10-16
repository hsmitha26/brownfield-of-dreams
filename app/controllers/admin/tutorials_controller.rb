# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def new
    @tutorial = Tutorial.new
  end

  def create
    new_tutorial = Tutorial.new(new_tutorial_params)
    new_tutorial.save
    if new_tutorial.save
      flash[:success] = 'Successfully added tutorial.'
      redirect_to tutorial_path(new_tutorial.id)
    else
      flash[:error] = 'Tutorial was not added.'
      redirect_to new_admin_tutorial_path
    end
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    flash[:success] = "Tutorial was deleted."
    redirect_to admin_dashboard_path
  end

  private

  def new_tutorial_params
    params.require(:tutorial).permit(:id, :title, :description, :thumbnail, :playlist_id)
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
