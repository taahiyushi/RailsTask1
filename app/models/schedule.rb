class Schedule < ApplicationRecord
    validates :title, :start_date, :end_date, presence: true     #必要な項目を入力しているか
    validates :title, length: { maximum: 20 }      #タイトルの文字数制限
    validate :end_date_after_start_date     #下のメソッドを定義してる
    private

    def end_date_after_start_date     #終了日が開始日よりも後の日付であることを検証して、終了日が開始日よりも前の場合、エラーメッセージが追加されます。
        return if end_date.blank? || start_date.blank?

        errors.add(:end_date, 'must be after the start date') if end_date < start_date
    end
end
  
