package main

import (
	"github.com/yeasin50/portfolio/config"
	"github.com/yeasin50/portfolio/internal/api"
)

func main() {
	cfg := config.Envs

	server := api.NewAPIServer(cfg.LocalHost(), cfg.LocalResourceDirPath)
	server.Server()

}
