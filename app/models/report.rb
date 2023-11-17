# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentions, foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :mentions, source: :mentioned_report

  has_many :reverse_mentions, class_name: 'Mention', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :reverse_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def update_mentions_from_content
    mentioning_report_ids = extract_report_ids_from_content
    current_mentioning_ids = mentioning_reports.pluck(:id)

    ids_to_remove = current_mentioning_ids - mentioning_report_ids
    ids_to_add = mentioning_report_ids - current_mentioning_ids

    Mention.where(mentioning_report_id: id, mentioned_report_id: ids_to_remove).destroy_all
    ids_to_add.each do |id|
      Mention.create(mentioning_report_id: self.id, mentioned_report_id: id)
    end
  end

  private

  def extract_report_ids_from_content
    total_reports = Report.count
    regex = %r{http://localhost:3000/reports/([1-#{total_reports}]+)}
    self.content.scan(regex).flatten.map(&:to_i)
  end
end
