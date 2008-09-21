class WebpagesController < ApplicationController
  
  layout 'admin', :except => :display_page
  
  # GET /site/webpages
  def index
    @webpages = Webpage.find(:all)
  end

  # GET /site/webpages/1
  def show
    @webpage = Webpage.find(params[:id], :include => :columns)
  end

  # GET /site/webpages/new
  def new
    @webpage = Webpage.new
  end

  # GET /site/webpages/1/edit
  def edit
    @webpage = Webpage.find(params[:id])
  end

  # POST /site/webpages
  def create
    @webpage = Webpage.new(params[:webpage])
    if @webpage.save
      flash[:notice] = 'Webpage was successfully created.'
      redirect_to(@webpage)
    else
      render :action => "new"
    end
  end

  # PUT /site/webpages/1
  def update
    @webpage = Webpage.find(params[:id])
    if @webpage.update_attributes(params[:webpage])
      flash[:notice] = 'Webpage was successfully updated.'
      redirect_to webpages_path
    else
      render :action => "edit"
    end
  end

  # DELETE /site/webpages/1
  def destroy
    @webpage = Webpage.find(params[:id])
    @webpage.destroy
    redirect_to(webpages_url)
  end

  def display_page
    @page = Webpage.find_by_url(params[:site])
    # SAM handle failure here - redirect to new
    raise("cannot find a Webpage for site #{params[:site]}") if @page.nil?
    render :layout => 'display_page'
  end
    
end
