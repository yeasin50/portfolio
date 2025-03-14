package models

import "time"

type MediaGroup struct {
	Title       string  `json:"title"`
	Description *string `json:"description"`
	Medias      []Media `json:"data"`
}

type Media struct {
	Type      string     `json:"type"`
	Url       string     `json:"url"`
	BlurHash  *string    `json:"blur_hash"`
	CreatedAt *time.Time `json:"created_at"`
}
