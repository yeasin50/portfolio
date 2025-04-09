package config

import (
	"fmt"
	"os"
)

type Config struct {
	Port                 string
	LocalResourceDirPath string
	// DBUser     string
	// DBPassword string
	// DBAddress  string
	// DBName     string
	// JWTSecret  string
}

func (s *Config) LocalHost() string {
	return fmt.Sprintf(":%s", s.Port)
}

var Envs = initConfig()

func initConfig() Config {

	return Config{
		Port:                 getEnv("PORT", "8080"),
		LocalResourceDirPath: "/database",
	}
}
func getEnv(key string, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}
