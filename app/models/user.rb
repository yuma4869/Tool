class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy
  has_many :tasks,foreign_key: 'user_id'

  validates :name,presence: true,uniqueness: true,format: { with: /\A[A-Za-z0-9]+\z/, message: "は特殊文字を含まない英数字のみで入力してください。" }
  validates :password, presence: true,format: { with: /\A[A-Za-z0-9]+\z/, message: "は特殊文字を含まない英数字のみで入力してください。" }
end
