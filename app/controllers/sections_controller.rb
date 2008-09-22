class SectionsController < ApplicationController
  
  layout 'admin'
  before_filter :find_column_via_webpage, :only => [ :show, :new, :edit, :create, :update, :destroy ]
  before_filter :find_section_via_site, :only => [ :set_title, :sort_bookmarks ]

  # REST scaffold actions
  
  def show
    @section = @column.sections.find(params[:id])
    render :template => 'sections/scaffold/show'
  end

  def new
    @section = @column.sections.build
    render :template => 'sections/scaffold/new'
  end

  def edit
    @section = @column.sections.find(params[:id])
    render :template => 'sections/scaffold/edit'
  end

  def create
    @section = @column.sections.build(params[:section])
    if @section.save
      flash[:notice] = 'Section was successfully created.'
      redirect_to webpage_column_path(@webpage, @column)
    else
      render :template => 'sections/scaffold/new'
    end
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = 'Section was successfully updated.'
      redirect_to webpage_column_path(@webpage, @column)
    else
      render :template => 'sections/scaffold/edit'
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to webpage_column_path(@webpage, @column)
  end
  
  # Ajax actions
  
  # in_place_edit_for :section, :title
  def set_title
    @section.update_attribute(:title, params[:value])
    render :text => @section.send(:title).to_s
  end
  
  # Reorder bookmarks in a section and/or move bookmark into section.
  # Parameters are:
  #  'id'                   => x
  #  'droptargetSection_x'  => [ array of bookmark IDs ]
  # Note we can get called for a column that is now empty.
  def sort_bookmarks
    nth_from_top = 1
    moved_bookmark = nil
    unless params[@section.droptarget_id].blank?
      params[@section.droptarget_id].each do |bookmark_id|
        # SAM Check bookmark belongs in this page.
        bookmark = Bookmark.find(bookmark_id)
        if bookmark.section_id != @section.id
          moved_bookmark = bookmark
          bookmark.section_id = @section.id
        end
        bookmark.nth_from_top_of_section = nth_from_top
        bookmark.save!
        nth_from_top += 1
      end
    end
    if moved_bookmark
      render :update do |page|
        page.ajax_flash_message "Bookmark #{moved_bookmark.legend} moved to section #{moved_bookmark.section.title}"
      end
    else
      render :text => ""
    end
  end
  
  private
  
  def find_column_via_webpage
    @webpage = Webpage.find(params[:webpage_id])
    @column = @webpage.columns.find(params[:column_id])
  end
  
  def find_section_via_site
    @page = Webpage.find_by_url(params[:site])
    @section = Section.find(:first,
      :select => 's.*',
      :from => 'sections AS s, columns AS c',
      :conditions => [ 's.id = ? AND s.column_id = c.id AND c.webpage_id = ?', params[:id], @page.id ] )
  end
    
end
