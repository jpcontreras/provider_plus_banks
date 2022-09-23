class Api::V1::BanksController < ApplicationController
  before_action :find_bank, only: %i[show update destroy]

  def index
    @banks = Bank.order(name: :desc)
    render json: @banks, status: :ok
  end

  def show
    render json: @bank, status: :ok
  end

  def create
    @bank = Bank.new(bank_params)
    @bank.save!
    render json: @bank, status: :created
  rescue => error
    render json: error.message, status: :unprocessable_entity
  end

  def destroy
    @bank.delete
    render json: '', status: :no_content
  end

  def update
    @bank.update(bank_params)
    render json: @bank, status: :ok
  end

  private
  def bank_params
    params.permit(:name)
  end

  def find_bank
    @bank = Bank.find(params[:id])
  end
end
