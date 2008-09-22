class BookmarksController < ApplicationController

  layout 'admin'
  
  before_filter :find_section

  # Administrative interface REST CRUD scaffold actions
  
  def new
    @bookmark = @section.bookmarks.build
    render :template => 'bookmarks/scaffold/new'
  end

  def edit
    @bookmark = @section.bookmarks.find(params[:id])
    render :template => 'bookmarks/scaffold/edit'
  end

  def create
    @bookmark = @section.bookmarks.build(params[:bookmark])
    if @bookmark.save
      flash[:notice] = 'Bookmark was successfully created.'
      redirect_to webpage_column_section_path(@webpage, @column, @section)
    else
      render :template => 'bookmarks/scaffold/new'
    end
  end

  def update
    @bookmark = @section.bookmarks.find(params[:id])
    if @bookmark.update_attributes(params[:bookmark])
      flash[:notice] = 'Bookmark was successfully updated.'
      redirect_to webpage_column_section_path(@webpage, @column, @section)
    else
      render :template => 'bookmarks/scaffold/edit'
    end
  end

  def destroy
    @bookmark = @section.bookmarks.find(params[:id])
    @bookmark.destroy
    redirect_to webpage_column_section_path(@webpage, @column, @section)
  end

  private
  
  def find_section
    @webpage = Webpage.find(params[:webpage_id])
    @column = @webpage.columns.find(params[:column_id])
    @section = @column.sections.find(params[:section_id])
  end
  
end
