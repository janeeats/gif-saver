class FoldersController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @folders = @user.folders

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @folder = Folder.find(params[:id])

    if request.path != user_folder_path(@user, @folder)
      redirect_to user_folder_path(@user, @folder), :status => :moved_permanently
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @folder }
    end
  end

  def new
    @folder = Folder.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @folder }
    end
  end

  def edit
    @folder = Folder.find(params[:id])

    if @folder.is_maintained_by?(@current_user)
      respond_to do |format|
        format.html
        format.json { render json: @folder}
      end
    else
      redirect_to root_path, :notice => "Yo! Don't mess with other people's folders!"
    end

  end

  def create
    @folder = current_user.folders.build(params[:folder])

    respond_to do |format|
      if @folder.save
        format.html { redirect_to user_folder_path(@folder.user, @folder), notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
      else
        format.html { render action: "new" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @folder = Folder.find(params[:id])

    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to user_folder_path(@folder.user, @folder), notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder = Folder.find(params[:id])
    
    if @folder.is_maintained_by?(@current_user)
      @folder.destroy
      @folder.gifs.each do |gif|
        gif.destroy
      end
      respond_to do |format|
        format.html { redirect_to user_folders_url(@current_user) }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, :notice => "Yo! Don't mess with other people's folders!"
    end
  end
end
