class ChangePositionToIntegerInPlayers < ActiveRecord::Migration[7.0]
  def up
    # Define a mapping from string positions to integers
    mapping = {
      'goalkeeper' => 0,
      'defender' => 1,
      'midfielder' => 2,
      'attacker' => 3
    }

    # Create a temporary column to store the integer values
    add_column :players, :temp_position, :integer

    # Update existing records based on the mapping
    Player.reset_column_information
    Player.find_each do |player|
      player.update!(temp_position: mapping[player.position])
    end

    # Remove the old position column
    remove_column :players, :position

    # Rename the temporary column to position
    rename_column :players, :temp_position, :position
  end

  def down
    # Define a reverse mapping from integers to strings
    reverse_mapping = {
      0 => 'goalkeeper',
      1 => 'defender',
      2 => 'midfielder',
      3 => 'attacker'
    }

    # Create a temporary column to store the string values
    add_column :players, :temp_position, :string

    # Update existing records based on the reverse mapping
    Player.reset_column_information
    Player.find_each do |player|
      player.update!(temp_position: reverse_mapping[player.position])
    end

    # Remove the old position column
    remove_column :players, :position

    # Rename the temporary column to position
    rename_column :players, :temp_position, :position
  end
end
