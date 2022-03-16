package store

import (
	"github.com/havebit/hexagonal/app/todo"
	"gorm.io/gorm"
)

type DB struct {
	db *gorm.DB
}

func NewDB(db *gorm.DB) *DB {
	return &DB{db: db}
}

func (db *DB) New(t *todo.Todo) error {
	return db.db.Create(t).Error
}
