package api

import (
	"time"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

type APIServer struct {
	addr string
}

func NewAPIServer(
	addr string,
	localDbPath string,
) *APIServer {
	return &APIServer{
		addr: addr,
	}
}

func (s *APIServer) Server() {
	r := gin.Default()
	r.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"GET"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	r.GET("/ping", func(c *gin.Context) {
		c.String(200, "pong")
	})

	portfolio := NewPortfolioService()
	portfolio.RegisterRoutes(r)

	r.Run(s.addr)
}
