class CreditController < ApplicationController

  require "payjp"
  # before_action :set_card

  def new
    card = Credit.where(user_id: current_user.id)
    redirect_to credit_path(card) if card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp_token'].blank?
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
      customer = Payjp::Customer.create(
      card: params['payjp_token'],
      ) # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存します。
      
      @card = Credit.new(user_id: current_user.id, customer_id: customer.id, number: customer.default_card)
    
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  
  end

  def delete #PayjpとCardデータベースを削除します
    card = Credit.where(user_id: current_user.id).first
    redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    card = Credit.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  # private

  # def set_card
  #   @card = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).present?
  # end
  

end