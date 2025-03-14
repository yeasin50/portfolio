package models

import "time"

type Project struct {
	Id        *string      `json:"id"`
	Title     string       `json:"title"`
	Category  string       `json:"category"`
	Roll      string       `json:"roll"`
	CreatedAt time.Time    `json:"created_at"`
	Thumbnail *Media       `json:"thumbnail"`
	Media     []MediaGroup `json:"media"`
}
