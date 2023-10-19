# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit destroy update]
  before_action :check_owner, only: %i[edit update destroy]

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def new
    @report = Report.new
  end

  def show; end

  def edit; end

  def create
    @report = current_user.reports.build(report_params)

    if @report.save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to book_url(@book), notice: t('controllers.common.notice_update', name: Book.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end

  def check_owner
    return if @report.user == current_user

    redirect_to reports_url, notice: '権限エラー'
  end
end
