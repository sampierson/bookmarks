class WebpagesController < ApplicationController
  
  # GET /site/webpages
  # GET /site/webpages.xml
  def index
    puts "In index()"
    @webpages = Webpage.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @webpages }
    end
  end

  # GET /site/webpages/1
  # GET /site/webpages/1.xml
  def show
    @webpage = Webpage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @webpage }
    end
  end

  # GET /site/webpages/new
  # GET /site/webpages/new.xml
  def new
    @webpage = Webpage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @webpage }
    end
  end

  # GET /site/webpages/1/edit
  def edit
    @webpage = Webpage.find(params[:id])
  end

  # POST /site/webpages
  # POST /site/webpages.xml
  def create
    @webpage = Webpage.new(params[:webpage])

    respond_to do |format|
      if @webpage.save
        flash[:notice] = 'Webpage was successfully created.'
        format.html { redirect_to(:id => @webpage) }
        format.xml  { render :xml => @webpage, :status => :created, :location => @webpage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @webpage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /site/webpages/1
  # PUT /site/webpages/1.xml
  def update
    @webpage = Webpage.find(params[:id])

    respond_to do |format|
      if @webpage.update_attributes(params[:webpage])
        flash[:notice] = 'Webpage was successfully updated.'
        format.html { redirect_to(:id => @webpage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @webpage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /site/webpages/1
  # DELETE /site/webpages/1.xml
  def destroy
    @webpage = Webpage.find(params[:id])
    @webpage.destroy

    respond_to do |format|
      format.html { redirect_to(webpages_url) }
      format.xml  { head :ok }
    end
  end

  def display_page
    @page = Webpage.find_by_url(params[:site])
    # SAM handle failure here - redirect to new
    raise("cannot find a Webpage for site #{params[:site]}") if @page.nil?
  end
    
end
