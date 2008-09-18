class SectionsController < ApplicationController
  
  layout 'admin'
  
  before_filter :find_column
  
  # GET /sections
  # GET /sections.xml
  def index
    # SAM Remove
  end

  # GET /sections/1
  # GET /sections/1.xml
  def show
    @section = @column.sections.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.xml
  def new
    @section = @column.sections.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = @column.sections.find(params[:id])
  end

  # POST /sections
  # POST /sections.xml
  def create
    @section = @column.sections.build(params[:section])

    respond_to do |format|
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        format.html { redirect_to webpage_column_path(@webpage, @column) }
        format.xml  { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.xml
  def update
    @section = Section.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        format.html { redirect_to webpage_column_path(@webpage, @column) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.xml
  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to webpage_column_path(@webpage, @column) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_column
    @webpage = Webpage.find(params[:webpage_id])
    @column = @webpage.columns.find(params[:column_id])
  end
  
end
