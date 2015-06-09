class LogsController < ApplicationController
 

  # GET /logs
  # GET /logs.json
  def index
    @logs = Log.page_statistics
    @min = @logs.last.visits
    @max = @logs.first.visits
    if !@current_user.try(:admin?)
      redirect_to films_path, notice: 'НЕТ ДОСТУП К ЖУРНАЛАМ'
    end
  end

  def load_chart_data
    if params[:from].blank? && params[:til].blank?
    #if (params.has_key?(:til) && params.has_key?(:from))
      @stats = Log.day_statistics(uri: params[:uri], from: params[:from], til: params[:til])
    else
      @stats = Log.day_statistics(uri: params[:uri], from: Date.parse(params[:from]), til: Date.parse(params[:til]))
    #   @stats = Log.day_statistics(uri: params[:uri], from: params[:from], til: params[:til])
    end
   # @stats = Log.day_statistics(uri: params[:uri], from: Date.parse(params[:from]), til: Date.parse(params[:til]))
    respond_to do |format|
      format.js
    end

  end

  # GET /logs/1
  # GET /logs/1.json
  def show
    @uri = params[:uri]
    @visitors = Log.select('users.email, date(logs.created_at)').where(uri: params[:uri]).joins(:user).order('"date(logs.created_at)" DESC')

    @visitors = @visitors.page(params[:page]).per(1)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

end
