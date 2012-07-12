class ScoreFilesController < ApplicationController
  before_filter :login_required
  # GET /score_files
  # GET /score_files.xml
  def index
    @score_files = ScoreFile.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @score_files }
    end
  end

  # GET /score_files/1
  # GET /score_files/1.xml
  def show
    @score_file = ScoreFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @score_file }
    end
  end

  # GET /score_files/new
  # GET /score_files/new.xml
  def new
    @score_file = ScoreFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @score_file }
    end
  end

  # GET /score_files/1/edit
  def edit
    @score_file = ScoreFile.find(params[:id])
  end

  # POST /score_files
  # POST /score_files.xml
  def create
    @score_file = ScoreFile.new(params[:score_file])
    
    respond_to do |format|
      if @score_file.save
        format.html { redirect_to(@score_file, :notice => 'ScoreFile was successfully created.') }
        format.xml  { render :xml => @score_file, :status => :created, :location => @score_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @score_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /score_files/1
  # PUT /score_files/1.xml
  def update
    @score_file = ScoreFile.find(params[:id])

    respond_to do |format|
      if @score_file.update_attributes(params[:score_file])
        format.html { redirect_to(@score_file, :notice => 'ScoreFile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @score_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /score_files/1
  # DELETE /score_files/1.xml
  def destroy
    @score_file = ScoreFile.find(params[:id])
    @score_file.destroy

    respond_to do |format|
      format.html { redirect_to(score_files_url) }
      format.xml  { head :ok }
    end
  end

  def download
    @score_file = ScoreFile.find(params[:id])
    send_file @score_file.diskfile,:filename=>@score_file.filename#, :type => "application/pdf"
  end

  def re_upload
    @score_file = ScoreFile.find(params[:id])
    respond_to do |format|
      if @score_file.update_attribute(:confirmed,false)
        flash[:notice]='设置成功'
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @score_file.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
