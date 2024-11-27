class ModifyMatchInterceptionsForGoalkeeperActions < ActiveRecord::Migration[7.0]
  def change
    change_table :match_interceptions do |t|
      # Remove unnecessary 'successful' boolean if you already have one
      t.remove :successful

      # Add a general 'successful' boolean for interception success
      t.boolean :successful, default: false

      # Goalkeeper-specific columns
      t.boolean :is_cross, default: false      # Whether it was a cross claim
      t.boolean :is_high_claim, default: false # Whether it was a high claim
      t.boolean :is_low_claim, default: false  # Whether it was a low claim
      t.string :body_part                      # The body part used (e.g., hands, feet)
      t.boolean :dropped_down, default: false   # Whether the goalkeeper dropped the ball

      # Set-piece specific columns
      t.boolean :is_corner, default: false      # Whether the interception was during a corner
      t.boolean :is_free_kick, default: false   # Whether the interception was during a free kick
    end
  end
end

