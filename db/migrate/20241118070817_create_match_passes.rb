class CreateMatchPasses < ActiveRecord::Migration[7.0]
  def change
    create_table :match_passes do |t|
      t.integer :match_id, null: false, index: true
      t.integer :player_id, null: false, index: true
      t.integer :team_id, null: false, index: true
      t.integer :minute, null: false
      t.boolean :is_successful, default: false, null: false
      t.boolean :is_key_pass, default: false
      t.boolean :is_cross, default: false
      t.boolean :is_assist, default: false
      t.string :pass_type, default: "short", null: false # e.g., "chipped", "flick", "through", "cross"
      t.string :pass_outcome, default: "incomplete", null: false # e.g., "completed", "intercepted", "out of bounds"
      t.decimal :pass_start_x, precision: 5, scale: 2, default: 0.0, null: false
      t.decimal :pass_start_y, precision: 5, scale: 2, default: 0.0, null: false
      t.decimal :pass_end_x, precision: 5, scale: 2, default: 0.0, null: false
      t.decimal :pass_end_y, precision: 5, scale: 2, default: 0.0, null: false
      t.decimal :pass_distance, precision: 5, scale: 2, default: 0.0, null: false
      t.string :pass_direction, default: "forward", null: false # e.g., "forward", "sideways", "backward"
      t.decimal :expected_assist_value, precision: 4, scale: 3, default: 0.0 # Probability of resulting in an assist
      t.integer :assister, index: true # ID of the player providing the assist, if any
      t.integer :receiver, index: true # Player receiving the pass
      t.bigint :user_id, null: false, index: true # User who recorded this pass

      t.timestamps
    end

    # Adding foreign key constraints (assuming related tables exist)
    add_foreign_key :match_passes, :matches, column: :match_id
    add_foreign_key :match_passes, :players, column: :player_id
    add_foreign_key :match_passes, :teams, column: :team_id
    add_foreign_key :match_passes, :players, column: :assister
    add_foreign_key :match_passes, :players, column: :receiver
    add_foreign_key :match_passes, :users, column: :user_id
  end
end
