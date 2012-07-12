class AdminController < ApplicationController
  before_filter :login_required,:require_admin
  
  def index
  end

  def users
    @users=User.all
    @user=User.new
  end

  def user_new
    @user=User.new
  end

  def user_create
    @user =User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice]='用户已经成功创建'
        format.html { redirect_to :action=>'users' }
        format.xml  { head :ok }
      else
        flash[:error]='用户创建出错'
        format.html { render :action => "user_new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  def user_edit
    @user=User.find(params[:id])
  end

  def user_update
    @user =User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice]='用户已经成功更新'
        format.html { redirect_to :action=>'users' }
        format.xml  { head :ok }
      else
        flash[:error]='用户更新出错'
        format.html { render :action => "user_edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  def user_destroy
    if user=User.find(params[:id])
      user.destroy
      flash[:notice]='用户已经删除'
    end
    redirect_to :action=>'users'
  end

  def files

    @exam=Exam.find(params[:id]) if params[:id]
    @exam||= Exam.active.first
    #@qx=Qx.find(params[:id])
    @qx=Qx.find(current_user.qx_id) if current_user.qx_id
    @schools=@qx.schools
  end

  def qx_merge
    #@qx=Qx.find(params[:id])
    @qx=Qx.find(current_user.qx_id) if current_user.qx_id
    @exam=Exam.find(params[:id])
    files=@qx.score_files_for(@exam)
    if filename=ScoreFile.merge(files, @qx.code)
      send_file filename,:filename=>"#{@exam.name}#{@qx.name.strip}成绩汇总.xls"
    else
      @schools=@qx.schools
      flash[:error]='数据合并失败！'
      render :action=>'files'
    end
    
  end

  def qx_pwd
    @qx=Qx.find(current_user.qx_id) if current_user.qx_id
    @schools=@qx.schools
    @users=User.find_all_by_school_id(@schools)
    @user=User.find(params[:id]) if params[:id]
  end

  def qx_pwd_save
    @user =User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice]='用户密码已经修改成功'
        format.html { redirect_to :action=>'qx_pwd' }
        format.xml  { head :ok }
      else
        flash[:error]='用户密码更新出错'
        @qx=Qx.find(current_user.qx_id) if current_user.qx_id
        @schools=@qx.schools
        @users=User.find_all_by_school_id(@schools)
        format.html { render :action => "qx_pwd" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

end
