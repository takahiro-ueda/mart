class CreditController < ApplicationController
  require "payjp"
    before_action :set_credit
  
    def new
      credit = Credit.where(user_id: current_user.id)
      redirect_to credit_path(credit) if credit.exists?
    end

    def create_credit
      @user = User.new(session["devise.regist_data"]["user"])
      @address = Address.new(session["address"])
      @credit = Credit.new(creditcard_params)
      unless @creditcard.valid?
        flash.now[:alert] = @credit.errors.full_messages
        render :new_credit and return
      end
      @user.build_address(@address.attributes)
      @user.build_credit(@credit.attributes)
      @user.save
      sign_in(:user, @user)
    end

    def pay #payjpとCreditのデータベース作成を実施します。
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      if params['payjp-token'].blank?
        redirect_to action: "new"
      else
        # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
        customer = Payjp::Customer.create(
        credit: params['payjp-token'],
        ) # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存します。
        
        @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, credit_id: customer.default_credit)
        
        if @credit.save
          redirect_to action: "show"
        else
          redirect_to action: "pay"
        end
      end
    
    end
  
    def delete #PayjpとCreditデータベースを削除します
      credit = Credit.where(user_id: current_user.id).first
      redirect_to action: "new"
    end
  
    def show #Creditのデータpayjpに送り情報を取り出します
      credit = Credit.where(user_id: current_user.id).first
      if credit.blank?
        redirect_to action: "new" 
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(credit.customer_id)
        @default_credit_information = customer.credits.retrieve(credit.credit_id)
      end
    end
  
    private
  
    def set_credit
      @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).present?
    end
end
