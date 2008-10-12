class WebpagesController < ApplicationController
  
  layout 'admin', :except => [ :display_page, :edit_page ]
  
  # Administrative interface REST CRUD scaffold actions
  
  def index
    @webpages = Webpage.find(:all)
    render :template => 'webpages/scaffold/index'
  end

  def show
    @webpage = Webpage.find(params[:id], :include => :columns)
    render :template => 'webpages/scaffold/show'
    
  end

  def new
    @webpage = Webpage.new
    render :template => 'webpages/scaffold/new'
    
  end

  def edit
    @webpage = Webpage.find(params[:id])
    render :template => 'webpages/scaffold/edit'
    
  end

  def create
    @webpage = Webpage.new(params[:webpage])
    if @webpage.save
      flash[:notice] = 'Webpage was successfully created.'
      redirect_to(@webpage)
    else
      render :template => 'webpages/scaffold/new'
    end
  end

  def update
    @webpage = Webpage.find(params[:id])
    if @webpage.update_attributes(params[:webpage])
      flash[:notice] = 'Webpage was successfully updated.'
      redirect_to webpages_path
    else
      render :template => 'webpages/scaffold/edit'
    end
  end

  def destroy
    @webpage = Webpage.find(params[:id])
    @webpage.destroy
    redirect_to(webpages_url)
  end

  # Users' interface actions
  
  def display_page
    @webpage = Webpage.find(:first,
                            :conditions => { :url => params[:site] },
                            :include => { :columns => { :sections => { :bookmarks => :image } } } )
    # SAM handle failure here - redirect to new
    raise("cannot find a Webpage for site #{params[:site]}") if @webpage.nil?
    render :layout => 'display_page'
  end
  
  def edit_page
    @webpage = Webpage.find(:first,
                            :conditions => { :url => params[:site] },
                            :include => { :columns => { :sections => { :bookmarks => :image } } } )
    # SAM handle failure here - redirect to new
    raise("cannot find a Webpage for site #{params[:site]}") if @webpage.nil?
    render :layout => 'display_page'
  end
    
end
