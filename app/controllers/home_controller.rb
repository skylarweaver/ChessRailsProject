class HomeController < ApplicationController

def index 
    @upcomingCamps = Camp.active.upcoming.chronological.paginate(page: params[:page]).per_page(5)
    @instructors = Instructor.active.alphabetical.paginate(page: params[:page]).per_page(5)
    if current_user
	    @personalUpcomingCamps = current_user.instructor.camps.active.upcoming.paginate(page: params[:page]).per_page(8)
	    @instructor = current_user.instructor
	    @username = current_user.username
	    @role = current_user.role
        @instructor.active ? @status = "Active" : @status = "Inactive"
	end
end


end
