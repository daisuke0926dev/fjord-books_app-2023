# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.order(:id).page(params[:page])
  end

  # これなに(new のアクションはcreateアクションと何が違うというか。いつ使うの)
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        # format.html { redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human) }
        # format.json { render :show, status: :created, location: @report }
      else
        # format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
