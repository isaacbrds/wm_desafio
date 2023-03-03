class CreateVacations < ActiveRecord::Migration[7.0]
  def change
    create_table :vacations do |t|
      t.datetime :start_date
      t.datetime :finish_date
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
