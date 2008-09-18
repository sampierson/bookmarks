class ColumnsController < ApplicationController

  layout 'admin'

  before_filter :find_webpage
  
  # GET /columns
  # GET /columns.xml
  def index
  end

  # GET /columns/1
  # GET /columns/1.xml
  def show
    @column = @webpage.columns.find(params[:id], :include => :sections)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @column }
    end
  end

  # GET /columns/new
  # GET /columns/new.xml
  def new
    @column = @webpage.columns.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @column }
    end
  end

  # GET /columns/1/edit
  def edit
    @column = @webpage.columns.find(params[:id])
  end

  # POST /columns
  # POST /columns.xml
  def create
    @column = @webpage.columns.build(params[:column])
    respond_to do |format|
      if @column.save
        flash[:notice] = 'Column was successfully created.'
        format.html { redirect_to(@webpage) }
        format.xml  { render :xml => @column, :status => :created, :location => @column }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /columns/1
  # PUT /columns/1.xml
  def update
    @column = @webpage.columns.find(params[:id])

    respond_to do |format|
      if @column.update_attributes(params[:column])
        flash[:notice] = 'Column was successfully updated.'
        format.html { redirect_to webpage_path(@webpage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /columns/1
  # DELETE /columns/1.xml
  def destroy
    @column = @webpage.columns.find(params[:id])
    @column.destroy

    respond_to do |format|
      format.html { redirect_to(columns_url) }
      format.xml  { head :ok }
    end
  end

  private
  
  def find_webpage
    @webpage = Webpage.find(params[:webpage_id])
  end

end
