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
        format.html { redirect_to user_gif_path(@gif.user, @gif), notice: 'Gif was successfully created.' }
        format.json { render json: @gif, status: :created, location: @gif }
      else
        format.html { render action: "new" }
        format.json { render json: @gif.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @gif = Gif.find(params[:id])

    if @gif.is_maintained_by?(@current_user)
      respond_to do |format|
        format.html
        format.json { render json: @gif}
      end
    else
      redirect_to root_path, :notice => "Yo, why you wanna mess with other people's gifs? That's not cool. Not cool..."
    end

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

    if @gif.is_maintained_by?(@current_user)
      @gif.destroy
      respond_to do |format|
        format.html { redirect_to user_gifs_url(@current_user) }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, :notice => "Yo, seriously?! Why are you trying to delete other people's gifs? Seriously not cool."
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

  def twitter
    @gif = Gif.find(params[:id])
    tweet = @gif.caption + " " + @gif.file.url
    if @current_user.has_identity?("twitter")
      @gif.post_to_twitter(@current_user, tweet)
      redirect_to @current_user, :notice => 'Posted to Twitter!'
    else
      redirect_to @current_user, :notice => 'Please enable uploads to Twitter.' 
    end
  end

  def superindex
    @gifs = Gif.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gifs }
    end
  end

end
