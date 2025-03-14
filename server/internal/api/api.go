package api

import "github.com/gin-gonic/gin"

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

	r.GET("/ping", func(c *gin.Context) {
		c.String(200, "pong")
	})

	portfolio := NewPortfolioService()
	portfolio.RegisterRoutes(r)

	r.Run(s.addr)
}
