class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      redirect_to :rooms
    else
      render :new
    end
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "ルームを更新しました。"
    else
      render :edit
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to :rooms
  end
  
  def search
    @rooms = Room.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  
  private
  def room_params
    params.require(:room).permit(:room_name, :introduction, :price, :address, :user_id, :room_image)
  end
  
end
