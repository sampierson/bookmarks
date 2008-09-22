class ColumnsController < ApplicationController

  layout 'admin'

  before_filter :find_webpage,       :only => [ :show, :new, :edit, :create, :update, :destroy ]
  before_filter :find_page_via_site, :only => [ :sort_sections, :insert_column_before, :delete_column ]

  # REST CRUD actions
  
  def show
    @column = @webpage.columns.find(params[:id], :include => :sections)
  end

  def new
    @column = @webpage.columns.build
  end

  def edit
    @column = @webpage.columns.find(params[:id])
  end

  def create
    @column = @webpage.columns.build(params[:column])
    if @column.save
      flash[:notice] = 'Column was successfully created.'
      redirect_to(@webpage)
    else
      render :action => "new"
    end
  end

  def update
    @column = @webpage.columns.find(params[:id])
    if @column.update_attributes(params[:column])
      flash[:notice] = 'Column was successfully updated.'
      redirect_to webpage_path(@webpage)
    else
      render :action => "edit"
    end
  end

  def destroy
    @column = @webpage.columns.find(params[:id])
    @column.destroy
    redirect_to webpage_path(@webpage)
  end
  
  # Ajax Actions

  # Reorder sections in a column and/or move section into column.
  # Parameters are:
  #  'id'                  => x
  #  'droptargetColumn_x'  => [ array of section IDs ]
  # Note we can get called for a column that is now empty.
  def sort_sections
    column = @page.columns.find(params[:id])
    nth_from_top = 1
    moved_section = nil
    unless params[column.droptarget_id].blank?
      params[column.droptarget_id].each do |section_id|
        # SAM Check sections belongs in this page.
        section = Section.find(section_id)
        if section.column_id != column.id
          @moved_section = section
          section.column_id = column.id
        end
        section.nth_section_from_top = nth_from_top
        section.save!
        nth_from_top += 1
      end
    end
  end
  
  # Insert a new column before :id column
  def insert_column_before
    @existing_column = @page.columns.find(params[:id])
    inserting_at_position = @existing_column.nth_from_left
    shift_columns_right = false
    @page.columns.each do |col|
      shift_columns_right = true if col == @existing_column
      if shift_columns_right
        col.nth_from_left += 1
        col.save!
      end
    end
    @new_column = @page.columns.create(:nth_from_left => inserting_at_position)
    #render :update do |page|
    #  ajax_flash_message page, "Inserted new column at position #{inserting_at_position}"
    #end
  end
  
  def delete_column
    @column = @page.columns.find(params[:id])
    @column.destroy
    # Renumber remaining columns.  No need to redraw entire page as that only uses IDs.
    nth_from_left = 1
    @page.columns.each do |col|
      col.nth_from_left = nth_from_left
      col.save!
      nth_from_left += 1
    end
  end

  private
  
  # Renumber sections from 1
  def renumber_sections_in_column(column)
    nth_from_top = 1
    column.sections.each do |section|
      section.nth_section_from_top = nth_from_top
      section.save!
      nth_from_top += 1
    end
  end
  
  def find_page_via_site
    @page = Webpage.find_by_url(params[:site])
  end
  
  def find_webpage
    @webpage = Webpage.find(params[:webpage_id])
  end

end
