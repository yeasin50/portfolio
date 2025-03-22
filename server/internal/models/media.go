package models

import "time"

type MediaGroup struct {
	Title       string  `json:"title"`
	Description *string `json:"description"`
	Medias      []Media `json:"data"`
}

type Media struct {
	Type      string     `json:"type"`
	Url       string     `json:"value"`
	UrlLowRes *string    `json:"low_res"`
	BlurHash  *string    `json:"blur_hash"`
	CreatedAt *time.Time `json:"created_at"`
}
