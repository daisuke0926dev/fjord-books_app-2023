# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]
  after_action :update_mentions_from_content, only: %i[create]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def update_mentions_from_content
    mentioned_report_ids = extract_report_ids_from_content
    current_mentioned_ids = @report.mentioned_reports.pluck(:id)

    ids_to_remove = current_mentioned_ids - mentioned_report_ids
    ids_to_add = mentioned_report_ids - current_mentioned_ids

    Mention.where(mentioning_report_id: @report.id, mentioned_report_id: ids_to_remove).destroy_all
    ids_to_add.each do |id|
      Mention.create(mentioning_report_id: @report.id, mentioned_report_id: id)
    end
  end

  def extract_report_ids_from_content
    total_reports = Report.count
    regex = %r{http://localhost:3000/reports/([1-#{total_reports}]+)}
    @report.content.scan(regex).flatten.map(&:to_i)
  end
end
