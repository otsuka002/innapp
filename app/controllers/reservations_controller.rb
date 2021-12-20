class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    progressday = day(@reservation.start_day,@reservation.end_day)
    @reservation.total_price = total_price(@reservation.room.price,@reservation.people,progressday)
    if @reservation.save
      redirect_to  :reservations, notice: "予約しました。"
    else
      render :new, alert: "予約されませんでした。"
    end
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to "/reservations",notice: "予約を取り消しました。"
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:start_day, :end_day, :people, :user_id, :room_id, :total_price)
  end
  
  def day(startday,endday)
    endday - startday
  end
  
  def total_price(price,people,day)
    price * people * day
  end
  
end
