# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_522_142_325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'cards', force: :cascade do |t|
    t.string 'front', null: false
    t.string 'back', null: false
    t.boolean 'is_reset', default: false
    t.date 'review_at', null: false
    t.float 'ease_factor', null: false
    t.integer 'interval', null: false
    t.integer 'repetitions', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'deck_id', null: false
    t.index %w[deck_id front], name: 'index_cards_on_deck_id_and_front', unique: true
    t.index ['deck_id'], name: 'index_cards_on_deck_id'
  end

  create_table 'decks', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.uuid 'user_id', null: false
    t.index %w[user_id title], name: 'index_decks_on_user_id_and_title', unique: true
    t.index ['user_id'], name: 'index_decks_on_user_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['id'], name: 'index_users_on_id', unique: true
    t.index ['name'], name: 'index_users_on_name', unique: true
  end

  add_foreign_key 'cards', 'decks'
  add_foreign_key 'decks', 'users'
end
