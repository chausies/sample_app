class MicropostsController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = current_user.feed.paginate(page: params[:page])
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Micropost successfully deleted!"
		redirect_to root_url
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content)
		end

		def correct_user
			if current_user.admin?
				@micropost = Micropost.find_by(id: params[:id])
			else
				@micropost = current_user.microposts.find_by(id: params[:id])
			end	
			redirect_to root_url, notice: "You can't delete another user's micropost ಠ_ಠ" if @micropost.nil?
		end
end