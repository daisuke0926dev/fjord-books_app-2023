# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit destroy update]

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  # これなに(new のアクションはcreateアクションと何が違うというか。いつ使うの)
  def new
    @report = Report.new
  end

  def show; end

  def edit; end

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

  def update
    respond_to do |format|
      if @report.update(report_params)
        # format.html { redi`rect_to book_url(@book), notice: t('controllers.common.notice_update', name: Book.model_name.human) }
        # format.json { re`nder :show, status: :ok, location: @book }
      else
        # format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human) }
      # format.json { head :no_content }
    end
  end

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
