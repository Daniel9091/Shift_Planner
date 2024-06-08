
class SectionGroupHistoriesController < ApplicationController
    def index
      @section_group_histories = SectionGroupHistory.all
    end
  
    def show
      @section_group_history = SectionGroupHistory.find(params[:id])
    end
  
    def new
      @section_group_history = SectionGroupHistory.new
    end
  
    def create
      @section_group_history = SectionGroupHistory.new(section_group_history_params)
      if @section_group_history.save
        redirect_to @section_group_history
      else
        render :new
      end
    end
  
    private
  
    def section_group_history_params
      params.require(:section_group_history).permit(:section_group_id, :user_id, :action)
    end
  end