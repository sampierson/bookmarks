class BookmarksController < ApplicationController

  layout 'admin'
  
  before_filter :find_section
  
  # GET /bookmarks
  # GET /bookmarks.xml
  def index
    # SAM Nuke
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.xml
  def show
    # SAM Nuke
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.xml
  def new
    @bookmark = @section.bookmarks.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = @section.bookmarks.find(params[:id])
  end

  # POST /bookmarks
  # POST /bookmarks.xml
  def create
    @bookmark = @section.bookmarks.build(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        flash[:notice] = 'Bookmark was successfully created.'
        format.html { redirect_to webpage_column_section_path(@webpage, @column, @section) }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.xml
  def update
    @bookmark = @section.bookmarks.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        flash[:notice] = 'Bookmark was successfully updated.'
        format.html { redirect_to webpage_column_section_path(@webpage, @column, @section) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.xml
  def destroy
    @bookmark = @section.bookmarks.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to webpage_column_section_path(@webpage, @column, @section) }
      format.xml  { head :ok }
    end
  end

  private
  
  def find_section
    @webpage = Webpage.find(params[:webpage_id])
    @column = @webpage.columns.find(params[:column_id])
    @section = @column.sections.find(params[:section_id])
  end
  
end
