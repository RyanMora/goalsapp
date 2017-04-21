class GoalsController < ApplicationController
  def new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to new_user_goal
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    if @goal.destroy
      redirect_to new_user_goal
    end
  end

  def show
    render :show
  end

  def edit
    render :edit
  end

  def update
    @goal = Goal.find(param[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash[:errors] = "Not valid inputs"
      redirect_to goal_url(@goal)
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :title, :user_id)
  end

end
