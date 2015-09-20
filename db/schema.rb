# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150917043939) do

  create_table "amistad", primary_key: "id_amistad", force: :cascade do |t|
    t.integer  "id_usuario",        limit: 4, null: false
    t.integer  "id_usuario_amigo",  limit: 4, null: false
    t.datetime "timestamp_amistad",           null: false
    t.integer  "vigente",           limit: 4
  end

  add_index "amistad", ["id_usuario"], name: "fk_usuario_amistades", using: :btree
  add_index "amistad", ["id_usuario_amigo"], name: "fk_amigo", using: :btree

  create_table "auditoria", primary_key: "id_auditoria", force: :cascade do |t|
    t.integer  "id_usuario",          limit: 4
    t.string   "id_usuario_db",       limit: 30
    t.string   "tabla",               limit: 20
    t.integer  "fila",                limit: 4
    t.string   "campo",               limit: 30
    t.string   "accion",              limit: 6
    t.string   "valor_old",           limit: 240
    t.string   "valor_new",           limit: 240
    t.datetime "timestamp_auditoria",             null: false
  end

  add_index "auditoria", ["id_usuario"], name: "fk_genera", using: :btree

  create_table "comentario", primary_key: "id_comentario", force: :cascade do |t|
    t.integer  "id_fotografia",        limit: 4,     null: false
    t.integer  "id_usuario",           limit: 4,     null: false
    t.text     "texto_comentario",     limit: 65535
    t.datetime "timestamp_comentario",               null: false
  end

  add_index "comentario", ["id_fotografia"], name: "fk_posee", using: :btree
  add_index "comentario", ["id_usuario"], name: "fk_hecho_por", using: :btree

  create_table "fotografia", primary_key: "id_fotografia", force: :cascade do |t|
    t.integer  "id_usuario",             limit: 4,     null: false
    t.string   "titulo_fotografia",      limit: 50
    t.text     "descripcion_fotografia", limit: 65535
    t.integer  "cantidad_comentarios",   limit: 4
    t.float    "promedio_valoracion",    limit: 24
    t.time     "hora_subida"
    t.date     "fecha_subida"
    t.datetime "timestamp_edicion",                    null: false
    t.integer  "disponible",             limit: 4
  end

  add_index "fotografia", ["id_usuario"], name: "fk_pertenece", using: :btree

  create_table "permiso", primary_key: "id_permiso", force: :cascade do |t|
    t.integer "id_usuario",          limit: 4,   null: false
    t.integer "tipo_permiso",        limit: 4
    t.string  "descripcion_permiso", limit: 250
  end

  add_index "permiso", ["id_usuario"], name: "fk_poseen", using: :btree

  create_table "usuario", primary_key: "id_usuario", force: :cascade do |t|
    t.string   "nombre_usuario",       limit: 50
    t.string   "apellido_paterno",     limit: 50
    t.string   "apellido_materno",     limit: 50
    t.string   "nombre_acceso",        limit: 50
    t.string   "password",             limit: 50
    t.string   "correo",               limit: 50
    t.string   "direccion",            limit: 50
    t.date     "fechanacimiento"
    t.string   "sexo",                 limit: 1
    t.integer  "cantidad_amigos",      limit: 4
    t.integer  "cantidad_fotos",       limit: 4
    t.string   "ip_last_login",        limit: 50
    t.datetime "timestamp_creacion",              null: false
    t.datetime "timestamp_last_login",            null: false
    t.string   "tipo_usuario",         limit: 20
    t.date     "fecha_pago"
    t.integer  "estado",               limit: 4
    t.string   "color_fondo",          limit: 6
    t.string   "estilo_letra",         limit: 20
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "NOMBRE_USUARIO",  limit: 255
    t.string   "NOMBRE_ACCESO",   limit: 255
    t.string   "PASSWORD",        limit: 255
    t.string   "CORREO",          limit: 255
    t.integer  "CANTIDAD_AMIGOS", limit: 4
    t.integer  "CANTIDAD_FOTOS",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "valoracion", primary_key: "id_valoracion", force: :cascade do |t|
    t.integer  "id_fotografia",        limit: 4, null: false
    t.integer  "id_usuario",           limit: 4, null: false
    t.integer  "valor",                limit: 4
    t.datetime "timestamp_valoracion",           null: false
  end

  add_index "valoracion", ["id_fotografia"], name: "fk_tiene", using: :btree
  add_index "valoracion", ["id_usuario"], name: "fk_dada_por", using: :btree

  add_foreign_key "amistad", "usuario", column: "id_usuario", primary_key: "id_usuario", name: "fk_usuario_amistades"
  add_foreign_key "amistad", "usuario", column: "id_usuario_amigo", primary_key: "id_usuario", name: "fk_amigo"
  add_foreign_key "auditoria", "usuario", column: "id_usuario", primary_key: "id_usuario", name: "fk_genera"
  add_foreign_key "comentario", "fotografia", column: "id_fotografia", primary_key: "id_fotografia", name: "fk_posee"
  add_foreign_key "comentario", "usuario", column: "id_usuario", primary_key: "id_usuario", name: "fk_hecho_por"
  add_foreign_key "fotografia", "usuario", column: "id_usuario", primary_key: "id_usuario", name: "fk_pertenece"
  add_foreign_key "permiso", "usuario", column: "id_usuario", primary_key: "id_usuario", name: "fk_poseen"
  add_foreign_key "valoracion", "fotografia", column: "id_fotografia", primary_key: "id_fotografia", name: "fk_tiene"
  add_foreign_key "valoracion", "usuario", column: "id_usuario", primary_key: "id_usuario", name: "fk_dada_por"
end
