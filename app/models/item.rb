class Item < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  acts_as_ordered_taggable_on :tags
    acts_as_taggable

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      item = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      item.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      item.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "bunrui", "bangou"]
  end



end
