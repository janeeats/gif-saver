class GifsController < ApplicationController
  skip_before_filter :login_required, :only => "show"


  def index
    @user = User.find(params[:user_id])
    @folders = @user.folders
    @gifs = @user.gifs
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gifs }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @gif = Gif.find(params[:id])
  end

  def new
    @gif = Gif.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gif }
    end
  end

  def create
    @gif = Gif.new(params[:gif])
    @gif.download_remote_gif(params[:gif][:file_remote_url])
    respond_to do |format|
      if @gif.save
        format.html { redirect_to @gif, notice: 'Gif was successfully created.' }
        format.json { render json: @gif, status: :created, location: @gif }
      else
        format.html { render action: "new" }
        format.json { render json: @gif.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @gif = Gif.find(params[:id])
  end

  def update
    @gif = Gif.find(params[:id])

    respond_to do |format|
      if @gif.update_attributes(params[:gif])
        format.html { redirect_to user_gif_path(@gif.folder.user, @gif), notice: 'Gif was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gif.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gif = Gif.find(params[:id])
    @gif.destroy

    respond_to do |format|
      format.html { redirect_to user_gifs_url(@current_user) }
      format.json { head :no_content }
    end
  end

  def facebook
    @gif = Gif.find(params[:id])
    if @current_user.has_identity?("facebook")    
      @gif.post_to_facebook(@current_user, @gif.caption)
      redirect_to @current_user, :notice => 'Posted to Facebook!'
    else
      redirect_to @current_user, :notice => 'Please enable uploads to Facebook.' 
    end
  end

end
