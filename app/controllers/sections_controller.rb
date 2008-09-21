class SectionsController < ApplicationController
  
  layout 'admin'
  before_filter :find_column_via_webpage, :only => [ :show, :new, :edit, :create, :update, :destroy ]
  before_filter :find_section_via_site, :only => [ :set_title ]

  # REST scaffold actions
  
  def show
    @section = @column.sections.find(params[:id])
  end

  def new
    @section = @column.sections.build
  end

  def edit
    @section = @column.sections.find(params[:id])
  end

  def create
    @section = @column.sections.build(params[:section])
    if @section.save
      flash[:notice] = 'Section was successfully created.'
      redirect_to webpage_column_path(@webpage, @column)
    else
      render :action => "new"
    end
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = 'Section was successfully updated.'
      redirect_to webpage_column_path(@webpage, @column)
    else
      render :action => "edit"
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
