class ScoresController < ApplicationController
  def index
    @exam=Exam.active.first
    @f_type=params[:f_type] || '0'
    if current_user.school

    @score_file = ScoreFile.find(:first,
      :conditions=>{:exam_id=>@exam,:school_id=>current_user.school,:f_type=>@f_type}
      )
    #@score_file =current_user.school.score_file_for(@exam) || ScoreFile.new
      if @score_file        
        @csv_data=@score_file.csv_data
        @error=@csv_data[:error]
        @data=@csv_data[:rows]
      else
        @score_file= ScoreFile.new
      end
    end
  end

  def create
    @exam=Exam.active.first
    @f_type=params[:score_file][:f_type]
    @score_file = ScoreFile.new(params[:score_file])
    @score_file.school_id=current_user.school_id
    @score_file.user_id=current_user.id
    respond_to do |format|
      if @score_file.save
        flash[:notice]='文件已成功上传'
        format.html { redirect_to(:action=>'index',:f_type=>@f_type) }
        format.xml  { render :xml => @score_file, :status => :created, :location => @score_file }
      else
        flash[:error]='文件上传有错误'
        format.html { render :action => "index",:f_type=>@f_type }
        format.xml  { render :xml => @score_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @exam=Exam.first
    
    @score_file = ScoreFile.find(params[:id])
    @score_file.user_id=current_user.id
    respond_to do |format|
      if @score_file.update_attributes(params[:score_file])
        flash[:notice]='操作成功'
        format.html { redirect_to(:action=>'index',:f_type=>@score_file.f_type)  }
        format.xml  { head :ok }
      else
        flash[:error]='操作出错'
#
#        @score_file = ScoreFile.find(params[:id])
#        if @score_file
#          @csv_data=@score_file.csv_data
#          @error=@csv_data[:error]
#          @data=@csv_data[:rows]
#        else
#          @score_file= ScoreFile.new
#        end
#
        format.html { render :action => "index" }
#        format.html { redirect_to(:action=>'index',:f_type=>@score_file.f_type)  }
        format.xml  { render :xml => @score_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    require 'csv'
    
    data=[]
    CSV::Reader.parse(File.open(args[:file])) do |row|
      data<<row
    end
  end

end
