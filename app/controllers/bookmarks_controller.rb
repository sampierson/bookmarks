class BookmarksController < ApplicationController

  layout 'admin'
  
  before_filter :find_section_via_webpage, :only => [ :show, :new, :edit, :create, :update, :destroy ]
  before_filter :find_bookmark_via_site,    :only => [ :edit_bookmark, :update_bookmark, :set_legend, :set_url ]

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

  # Users' interface Ajax actions
  
  def edit_bookmark
  end
  
  # Bookmark editing is actually done by in-place editors.
  # This rjs action closes the edit window, and updates the original bookmark.
  def update_bookmark
    puts "SAM bookmark=#{@bookmark.inspect}"
  end
  
  def set_legend
    @bookmark.update_attribute(:legend, params[:value])
    render :text => @bookmark.send(:legend).to_s
  end

  def set_url
    @bookmark.update_attribute(:url, params[:value])
    render :text => @bookmark.send(:url).to_s
  end
  
  private
  
  def find_section_via_webpage
    @webpage = Webpage.find(params[:webpage_id])
    @column = @webpage.columns.find(params[:column_id])
    @section = @column.sections.find(params[:section_id])
  end
  
  def find_bookmark_via_site
    @webpage = Webpage.find_by_url(params[:site])
    @bookmark = Bookmark.find(:first,
      :select => "b.*",
      :from => 'bookmarks AS b, sections AS s, columns AS c, webpages AS w',
      :conditions => [ "b.id = ? AND b.section_id = s.id AND s.column_id = c.id AND c.webpage_id = ?", params[:id], @webpage.id ]
    )
  end
  
end
