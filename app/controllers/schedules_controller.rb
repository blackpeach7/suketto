class SchedulesController < ApplicationController

    def index
        @schedules = Schedule.where(publicflag: 1)
    end
    
    def new
        @sched = current_user.schedules.build
        @schedules = current_user.schedules
    end
    
    def create
      #@sched = Schedules.new(schedule_params)
      @sched =  current_user.schedules.build(schedule_params)
      if @sched.save
          flash[:success] = 'スケジュールが正常に投稿されました'
          redirect_to @sched
      else
          flash.now[:danger] = 'スケジュールが投稿されませんでした'
          render :new
      end    
    end  
    
    def destroy 
        @sched.destroy
        flash[:success] ='スケジュールを削除しました'
        redeirect_back(fallvack_location: root_path)
    end
    
    def show
        @schedule = Schedule.find(params[:id])
    end
    
    private
    def schedule_params
         params.require(:schedule).permit(:start, :kind, :place, :publicflag, :content, :capacity, :deadline)
    end
end
