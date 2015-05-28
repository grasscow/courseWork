class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  # GET /logs
  # GET /logs.json
  def index
    @logs = Log.page_statistics
  end

  def load_chart_data
    @stats = Log.day_statistics(uri: params[:uri], from: params[:from], til: params[:til])
    respond_to do |format|
      format.js
    end
  end

  # GET /logs/1
  # GET /logs/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end
end
