class Admin::FilesController < ApplicationController
	before_filter :login_required,:require_admin
	before_filter :find_exam

	def index
	    
	    
	    if current_user.is_admin && current_user.qx_id
	      @qx=Qx.find(current_user.qx_id)
	      @schools=@qx.schools      
	    else
	      @schools=School.all :order=>'qx_id'
	    end
	end

	def show
		@score_file=ScoreFile.find(params[:id])
	    @f_type=@score_file.f_type
	    if @score_file
	        @csv_data=@score_file.csv_data
	        @error=@csv_data[:error]
	        @data=@csv_data[:rows]
	      else
	        @score_file= ScoreFile.new
	      end
		respond_to do |format|	
			format.html {render :layout=>false}
			format.csv {send_file @score_file.diskfile,:filename=>@score_file.filename}
		end

	    
	end

	def update
		@score_file=ScoreFile.find(params[:id])
		respond_to do |format|
		    if @score_file.update_attributes(params[:score_file])
		        format.html { redirect_to(admin_exam_files_url(@exam), :notice => '操作成功.') }
		        format.xml  { head :ok }
		    else
		        format.html { render :action => "edit" }
		        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
		    end
	    end
	end

	protected

	def find_exam
		@exam=Exam.find(params[:exam_id]) if params[:exam_id]
	    @exam ||= Exam.active.first
	end

end
