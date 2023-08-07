class Task < ApplicationRecord
    include RankedModel 
    ranks :row_order , with_same: :user_id 
    belongs_to :user, optional: true

    validates :title, presence: true,format: { with: /\A[A-Za-z0-9]+\z/, message: "は特殊文字を含まない英数字のみで入力してください。" }
    validates :content,format: { with: /\A[A-Za-z0-9]+\z/, message: "は特殊文字を含まない英数字のみで入力してください。" }
    validates :time, presence: true
end
