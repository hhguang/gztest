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
    
    if current_user.is_admin && current_user.qx_id
      @qx=Qx.find(current_user.qx_id)
      @schools=@qx.schools      
    else
      @schools=School.all :order=>'qx_id'
    end
  end

  def file_show
    @score_file=ScoreFile.find(params[:id])
    @f_type=@score_file.f_type
    if @score_file
        @csv_data=@score_file.csv_data
        @error=@csv_data[:error]
        @data=@csv_data[:rows]
      else
        @score_file= ScoreFile.new
      end
    render :layout=>false
  end

  def qx_file
    require 'csv'
    require 'FasterCSV'
    @f_type=params[:f_type]
    
    @exam=Exam.find(params[:id])
    if current_user.qx_id
      @qx=Qx.find(current_user.qx_id)
      files=ScoreFile.find_all_by_exam_id_and_f_type_and_school_id_and_confirmed(@exam.id,params[:f_type],@qx.schools,true)
    else
      files=ScoreFile.find_all_by_exam_id_and_f_type_and_confirmed(@exam.id,params[:f_type],true,:include=>[:school])
    end

    title=ScoreFile::EXCELCONFIG[@f_type.to_i][:name]
    caption=[]
    caption<<Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县代码')
    caption<<Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '区县')
    caption<<Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校代码')
    caption<<Iconv.conv('gbk//IGNORE','utf-8//IGNORE', '学校')
    caption.concat ScoreFile::EXCELCONFIG[@f_type.to_i][:columns].map { |column| Iconv.conv('gbk//IGNORE','utf-8//IGNORE',column['name']) }
#    xls_report = StringIO.new
#    book = Spreadsheet::Workbook.new
#    sheet1 = book.create_worksheet :name => ScoreFile::EXCELCONFIG[@f_type.to_i][:name]
#    count_col=0
#    ScoreFile::EXCELCONFIG[@f_type.to_i][:columns].each do |column|
#      sheet1[0,count_col]=column['name']
#      count_col+=1
#    end
#
#    count_row = 1
#    files.each do |file|
#      first_row=true
#      FasterCSV.parse(File.open(file.diskfile)) do |row|
#        if first_row
#          first_row=false
#        else
#          count_col=0
#          row.each do |cell|
#            sheet1[count_row,count_col]=Iconv.conv('utf-8//IGNORE','gbk//IGNORE',cell)
#            count_col += 1
#          end
#          count_row += 1
#        end
#
#      end
#    end
#
#
#    book.write xls_report
#    xls_report.string
#
#    send_data(xls_report.string,
#          :type => "text/excel;charset=utf-8; header=present",
#          :filename => "#{title}#{Time.now.strftime("%Y%m%d")}.xls")
    
    csvtemp=FasterCSV.generate do |csv|
      csv<<caption

      files.each do |file|
        first_row=true
        row_head=[]
        row_head<<file.school.qx.code
        row_head<<Iconv.conv('gbk//IGNORE','utf-8//IGNORE', file.school.qx.name)
        row_head<<file.school.code
        row_head<<Iconv.conv('gbk//IGNORE','utf-8//IGNORE', file.school.name)
        FasterCSV.parse(File.open(file.diskfile)) do |row|
          row_temp=[]
          if first_row
            first_row=false
          else
            row_temp.concat row_head
            row_temp.concat row
            
            csv<<row_temp
          end
        end
      end
    end

    send_data(csvtemp,
      :type => "text/csv;charset=utf-8; header=present",
      :filename => "#{title}#{Time.now.strftime("%Y%m%d")}.csv")
  end

  def qx_merge
    #@qx=Qx.find(params[:id])
    #@f_type=params[f_type]
    @qx=Qx.find(current_user.qx_id) if current_user.qx_id
    @exam=Exam.find(params[:id])
    #files=@qx.score_files_for(@exam)
    files=@qx.score_files_for(@exam)
    #files=ScoreFile.find_all_by_exam_id_and_f_type_and_school_id(@exam.id,params[f_type],@qx.schools)
    if filename=ScoreFile.merge_csv(files, @qx.code)
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
