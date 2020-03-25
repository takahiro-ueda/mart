class PurchaseController < ApplicationController
  require 'payjp'
  before_action :byebye

  def byebye
    if user_signed_in?
      set_credit
    else
      redirect_to step1_signup_index_path
    end
  end

  def index
    @item = Item.find(params[:item_id])
  end

  def done
    @item = Item.find(params[:item_id])
  end

  def pay
    @item = Item.find(params[:item_id])
    credit = Credit.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.secrets.payjp_private_key
    Payjp::Charge.create(
      :amount => @item.price, #支払金額（itemテーブル等に紐づけても良い）
      :customer => card.customer_id, #顧客ID
      :currency => 'jpy', #日本円
    )
    @item.buyer = current_user.id
    @item.save
    redirect_to action: 'done' #完了画面に移動
  end

  private

  def set_credit
    @credit = Credit.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
