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

  def drop_section
    find_page_via_site
    new_column = @page.columns.find(params[:column_id])
    section = Section.find(:first,
      :select => 's.*',
      :from => 'sections AS s, columns AS c',
      :conditions => [ 's.id = ? AND s.column_id = c.id AND c.webpage_id = ?', params[:id], new_column.webpage.id ] )
    old_column = section.column
    # Associate section with our column.  Give it sequence 999 to put it at the bottom.
    section.nth_section_from_top = 999
    new_column.sections << section # Automatically saved
    renumber_sections_in_column(old_column)
    renumber_sections_in_column(new_column)
    render :update do |page|
      page.replace_html old_column.dom_id, :partial => 'column', :object => old_column
      page.replace_html new_column.dom_id, :partial => 'column', :object => new_column
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
