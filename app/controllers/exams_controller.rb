class ExamsController < ApplicationController
  before_filter :login_required
  # GET /exams
  # GET /exams.xml
  def index
    @exams = Exam.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exams }
    end
  end

  # GET /exams/1
  # GET /exams/1.xml
  def show
    @exam = Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/new
  # GET /exams/new.xml
  def new
    @exam = Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
  end

  # POST /exams
  # POST /exams.xml
  def create
    @exam = Exam.new(params[:exam])

    respond_to do |format|
      if @exam.save
        format.html { redirect_to(@exam, :notice => 'Exam was successfully created.') }
        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.xml
  def update
    @exam = Exam.find(params[:id])

    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        format.html { redirect_to(@exam, :notice => 'Exam was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.xml
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to(exams_url) }
      format.xml  { head :ok }
    end
  end

  def set_closed
    @exam = Exam.find(params[:id])
    respond_to do |format|
      if @exam.update_attribute(:closed,!@exam.closed)
        flash[:notice]="successfully"
        format.html { redirect_to(:action =>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  def report
    @exam = Exam.find(params[:id])
    @schools=School.all :order=>'qx_id'
  end

  def download
    @exam = Exam.find(params[:id])
    files=@exam.score_files
    if filename=ScoreFile.merge(files, @exam.name)
      send_file filename,:filename=>"#{@exam.name}成绩汇总.xls"
    else
      @exams = Exam.all
      flash[:error]='数据合并失败！'
      render :action=>'index'
    end
  end
end
