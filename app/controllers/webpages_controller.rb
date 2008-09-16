class WebpagesController < ApplicationController
  # GET /webpages
  # GET /webpages.xml
  def index
    @webpages = Webpage.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @webpages }
    end
  end

  # GET /webpages/1
  # GET /webpages/1.xml
  def show
    @webpage = Webpage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @webpage }
    end
  end

  # GET /webpages/new
  # GET /webpages/new.xml
  def new
    @webpage = Webpage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @webpage }
    end
  end

  # GET /webpages/1/edit
  def edit
    @webpage = Webpage.find(params[:id])
  end

  # POST /webpages
  # POST /webpages.xml
  def create
    @webpage = Webpage.new(params[:webpage])

    respond_to do |format|
      if @webpage.save
        flash[:notice] = 'Webpage was successfully created.'
        format.html { redirect_to(@webpage) }
        format.xml  { render :xml => @webpage, :status => :created, :location => @webpage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @webpage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /webpages/1
  # PUT /webpages/1.xml
  def update
    @webpage = Webpage.find(params[:id])

    respond_to do |format|
      if @webpage.update_attributes(params[:webpage])
        flash[:notice] = 'Webpage was successfully updated.'
        format.html { redirect_to(@webpage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @webpage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /webpages/1
  # DELETE /webpages/1.xml
  def destroy
    @webpage = Webpage.find(params[:id])
    @webpage.destroy

    respond_to do |format|
      format.html { redirect_to(webpages_url) }
      format.xml  { head :ok }
    end
  end
end
