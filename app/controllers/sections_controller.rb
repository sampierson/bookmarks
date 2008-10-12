class SectionsController < ApplicationController
  
  layout 'admin'
  before_filter :find_column_via_webpage, :only => [ :show, :new, :edit, :create, :update, :destroy ]
  before_filter :find_section_via_site, :only => [ :set_title, :sort_bookmarks ]

  # Administrative interface REST CRUD scaffold actions
  
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
  
  # Users' interface Ajax actions
  
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
        bookmark = Bookmark.find(bookmark_id)
        raise "Sorry this bookmark belongs to a different web page" if bookmark.section.column.webpage != @webpage
        if bookmark.section_id != @section.id
          bookmark.section_id = @section.id
          moved_bookmark = bookmark
        end
        bookmark.nth_from_top_of_section = nth_from_top
        bookmark.save!
        nth_from_top += 1
      end
    end
    if moved_bookmark
      render :update do |page|
        #page.ajax_flash_message "Bookmark #{moved_bookmark.legend} moved to section #{@section.title}"
      end
    else
      render :text => ""
    end
  end
  
  def new_section
    @webpage = Webpage.find_by_url(params[:site])
    @column = @webpage.columns.find(params[:column_id])
    @new_section = @column.sections.create(:title => "New Section",
                                           :nth_section_from_top => @column.sections.size + 1)
  end
  
  private
  
  def find_column_via_webpage
    @webpage = Webpage.find(params[:webpage_id])
    @column = @webpage.columns.find(params[:column_id])
  end
  
  def find_section_via_site
    @webpage = Webpage.find_by_url(params[:site])
    @section = @webpage.sections.find(:first, :conditions => [ 'sections.id = ?', params[:id] ])
  end
    
end
