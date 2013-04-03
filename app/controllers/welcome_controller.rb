class WelcomeController < ApplicationController
  before_filter :login_required,:except=>'help'

  def index
    

    if @exam=Exam.active.first
    if current_user.school
    @score_file =current_user.school.score_file_for(@exam) || ScoreFile.new
    @file=current_user.school.score_file_for(@exam)
    
    end
    end
    #todo:@exams=Exam.actives //需要取出所有开启的考试，并将考试ID传递给SCORES_CONTROLLER
  end

  def show
    

    @file=ScoreFile.find(params[:id])
    @exam=@file.exam
    render :layout=>false
  end

  def file
    @file=ScoreFile.find(params[:id])
    @data=@file.data
    @exam=@file.exam
  end

  def create
    @exam=Exam.first
    @score_file = ScoreFile.new(params[:score_file])
    @score_file.school_id=current_user.school_id
    @score_file.user_id=current_user.id
    respond_to do |format|
      if @score_file.save
        flash[:notice]='文件已成功上传'
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @score_file, :status => :created, :location => @score_file }
      else
        flash[:error]='文件上传有错误'
        format.html { render :action => "index" }
        format.xml  { render :xml => @score_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @exam=Exam.first
    if current_user.school
    @file=current_user.school.score_file_for(@exam)
    end
    @score_file = ScoreFile.find(params[:id])
    @score_file.user_id=current_user.id
    respond_to do |format|
      if @score_file.update_attributes(params[:score_file])
        flash[:notice]='操作成功'
        format.html { redirect_to(:action=>'index')  }
        format.xml  { head :ok }
      else
        flash[:error]='操作出错'
        format.html { render :action => "index" }
        format.xml  { render :xml => @score_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  def admin
    
  end

  def person
    @user=User.find(params[:id])
    unless @user && current_user.id==@user.id
      flash[:error]='您没有权限'
      redirect_to '/'
    end
  end

  def person_update
    @user =User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice]='用户已经成功更新'
        format.html { redirect_to :action=>'person',:id=>@user }
        format.xml  { head :ok }
      else
        flash[:error]='用户更新出错'
        format.html { render :action => "person" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  def help
    
  end

  
end
