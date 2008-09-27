class ColumnsController < ApplicationController

  layout 'admin'

  before_filter :find_webpage,       :only => [ :show, :new, :edit, :create, :update, :destroy ]
  before_filter :find_page_via_site, :only => [ :sort_sections, :insert_column_before, :add_column_on_right, :delete_column ]

  # Administrative interface REST CRUD scaffold actions
  
  def show
    @column = @webpage.columns.find(params[:id], :include => :sections)
    render :template => 'columns/scaffold/show'
  end

  def new
    @column = @webpage.columns.build
    render :template => 'columns/scaffold/new'
  end

  def edit
    @column = @webpage.columns.find(params[:id])
    render :template => 'columns/scaffold/edit'
  end

  def create
    @column = @webpage.columns.build(params[:column])
    if @column.save
      flash[:notice] = 'Column was successfully created.'
      redirect_to(@webpage)
    else
      render :template => 'columns/scaffold/new'
    end
  end

  def update
    @column = @webpage.columns.find(params[:id])
    if @column.update_attributes(params[:column])
      flash[:notice] = 'Column was successfully updated.'
      redirect_to webpage_path(@webpage)
    else
      render :template => 'columns/scaffold/edit'
    end
  end

  def destroy
    @column = @webpage.columns.find(params[:id])
    @column.destroy
    redirect_to webpage_path(@webpage)
  end
  
  # Users' interface Ajax actions

  # Reorder sections in a column and/or move section into column.
  # Parameters are:
  #  'id'                  => x
  #  'droptargetColumn_x'  => [ array of section IDs ]
  # Note we can get called for a column that is now empty.
  def sort_sections
    column = @webpage.columns.find(params[:id])
    nth_from_top = 1
    moved_section = nil
    unless params[column.droptarget_id].blank?
      params[column.droptarget_id].each do |section_id|
        section = Section.find(section_id)
        raise "Sorry this section belongs to a different web page" if section.column.webpage != @webpage
        if section.column_id != column.id
          moved_section = section
          section.column_id = column.id
        end
        section.nth_section_from_top = nth_from_top
        section.save!
        nth_from_top += 1
      end
    end
    # Scriptaculous has already reordered the sections in the page for us.
    # However if a section wasn't previously in this column, send a flash message.
    if moved_section
      moved_section.reload
      render :update do |page|
        page.ajax_flash_message "Section #{moved_section.title} moved to column #{moved_section.column.nth_from_left}"
      end
    else
      render :text => ''
    end
  end
  
  # Insert a new column before :id column
  def insert_column_before
    @existing_column = @webpage.columns.find(params[:id])
    inserting_at_position = @existing_column.nth_from_left
    start_shifting_columns_right = false
    @webpage.columns.each do |col|
      start_shifting_columns_right = true if col == @existing_column
      if start_shifting_columns_right
        col.nth_from_left += 1
        col.save!
      end
    end
    @new_column = @webpage.columns.create(:nth_from_left => inserting_at_position)
  end
  
  # Insert a new column on the far right hand side
  def add_column_on_right
    current_rightmost_column = Column.maximum(:nth_from_left, :conditions => "webpage_id = #{@webpage.id}")
    new_column_position = (current_rightmost_column || 0) + 1
    @new_column = @webpage.columns.create(:nth_from_left => new_column_position)
  end
  
  def delete_column
    @column = @webpage.columns.find(params[:id])
    @old_sections = @column.sections
    @column.destroy
    renumber_columns_in_webpage(@webpage)
  end

  private
  
  def renumber_columns_in_webpage(webpage)
    nth_from_left = 1
    webpage.columns.each do |col|
      col.nth_from_left = nth_from_left
      col.save!
      nth_from_left += 1
    end
  end
  
  def renumber_sections_in_column(column)
    nth_from_top = 1
    column.sections.each do |section|
      section.nth_section_from_top = nth_from_top
      section.save!
      nth_from_top += 1
    end
  end
  
  def find_page_via_site
    @webpage = Webpage.find_by_url(params[:site])
  end
  
  def find_webpage
    @webpage = Webpage.find(params[:webpage_id])
  end

end
