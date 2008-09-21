class ColumnsController < ApplicationController

  layout 'admin'

  before_filter :find_webpage, :only => [ :show, :new, :edit, :create, :update, :destroy ]

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

  #def drop_section
  #  find_page_via_site
  #  new_column = @page.columns.find(params[:column_id])
  #  section = Section.find(:first,
  #    :select => 's.*',
  #    :from => 'sections AS s, columns AS c',
  #    :conditions => [ 's.id = ? AND s.column_id = c.id AND c.webpage_id = ?', params[:id], new_column.webpage.id ] )
  #  old_column = section.column
  #  # Associate section with our column.  Give it sequence 999 to put it at the bottom.
  #  section.nth_section_from_top = 999
  #  new_column.sections << section # Automatically saved
  #  renumber_sections_in_column(old_column)
  #  renumber_sections_in_column(new_column)
  #  render :update do |page|
  #    page.replace_html old_column.dom_id, :partial => 'column', :object => old_column
  #    page.replace_html new_column.dom_id, :partial => 'column', :object => new_column
  #  end
  #end

  # Reorder sections in a column and/or move section into column.
  # Parameters are:
  #  'column_id' => x
  #  'column_x'  => [ array of section IDs ]
  def sort_sections
    find_page_via_site
    column = @page.columns.find(params[:column_id])
    nth_from_top = 1
    moved_section = nil
    params[column.dom_id].each do |section_id|
      # SAM Check sections belongs in this page.
      section = Section.find(section_id)
      if section.column_id != column.id
        moved_section = section
        section.column_id = column.id
      end
      section.nth_section_from_top = nth_from_top
      section.save!
      nth_from_top += 1
    end
    # Scriptaculous has already reordered these in the page for us.
    # If a column didn't used to be here, send a flash message.
    if moved_section
      render :update do |page|
        page.replace_html 'flash', "<div class=flash-notice>"+
                                   "Section #{moved_section.title} moved to column #{moved_section.column.nth_from_left}"+
                                   "</div>"
        page.visual_effect(:appear, 'flash', :duration => 1)
        #page.visual_effect(:blind_down, 'flash', :duration => 1)
        page.visual_effect(:fade, 'flash', :delay => 5, :duration => 1)
        page.visual_effect(:blind_up, 'flash', :delay => 5, :duration => 1)
#        flash_id = Time.now.strftime("flash_%H%M%S")
#        page.insert_html :bottom, 'flash', "<div id=#{flash_id} class=flash-notice>"+
#                                   "Section #{moved_section.title} moved to column #{moved_section.column.nth_from_left}"+
#                                   "</div>"
#        page.visual_effect(:appear, flash_id, :duration => 1)
#        page.visual_effect(:blind_down, flash_id, :duration => 1)
#        page.visual_effect(:fade, flash_id, :delay => 5, :duration => 1)
#        page.visual_effect(:blind_up, flash_id, :delay => 5, :duration => 1, :afterFinish => "function() { #{flash_id}.remove(); }")
      end
    else
      render :text => ''
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
