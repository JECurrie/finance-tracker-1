class StocksController < ApplicationController
    
    def create
        if params[:stock_id].present?
            @user_stock = UserStock.new(stock_id: params[:stock_id], user: current_user)
        else
            stock = Stock.find_by_ticker(params[:stock_ticker])
            if stock
                @user_stock = Stock.new(user: current_user, stock: stock)
            else
                stock = Stock.new_from_lookup(params[:stock_ticker])
            end
        end
    end
    
    
    def search
        if params[:stock]
            @stock = Stock.find_by_ticker(params[:stock])
            @stock ||= Stock.new_from_lookup(params[:stock])
        end
        
        if @stock
            # render json: @stock
            render partial: 'lookup'
        else
            render status: :not_found, nothing: true
        end
    end

end